# Ractor r
#                  +-------------------------------------------+
#                  | incoming                         outgoing |
#                  | port                                 port |
#    r.send(obj) ->*->[incoming queue]     Ractor.yield(obj) ->*-> r.take
#                  |                |                          |
#                  |                v                          |
#                  |           Ractor.receive                  |
#                  +-------------------------------------------+
#
#
# Connection example:
#   r2.send obj on r1、Ractor.receive on r2
#   +----+     +----+
#   * r1 |---->* r2 *
#   +----+     +----+
#
#
# Connection example:
#   Ractor.yield(obj) on r1, r1.take on r2
#   +----+     +----+
#   * r1 *---->- r2 *
#   +----+     +----+
#
# Connection example:
#   Ractor.yield(obj) on r1 and r2,
#   and waiting for both simultaneously by Ractor.select(r1, r2)
#
#   +----+
#   * r1 *------+
#   +----+      |
#               +----> Ractor.select(r1, r2)
#   +----+      |
#   * r2 *------|
#   +----+
