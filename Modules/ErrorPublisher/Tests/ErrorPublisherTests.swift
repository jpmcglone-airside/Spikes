@testable import ErrorPublisher
import Nimble
import Quick

class ErrorPublisherTests: QuickSpec {
  override func spec() {
    var errorPublisher: ErrorPublisher!
    var errorLogger: ErrorLogger!

    describe("the Error Publisher is initialized") {
      beforeEach {
        errorPublisher = ErrorPublisher()
      }

      it("has everything you need to get started") {
        expect(errorPublisher).toNot(beNil())
      }

      context("the Error Logger is initialized") {
        beforeEach {
          errorLogger = ErrorLogger()
        }

        it("is proper") {
          expect(errorLogger.errors.count) == 0
        }

        context("the Error Logger is subscribed to the publisher") {
          beforeEach {
            errorPublisher.subscribe(errorLogger)
          }

          context("publish one error") {
            beforeEach {
              let error = PublishableError(ErrorKey("test"))
              errorPublisher.publish(error)
            }

            it("should have one error in logger") {
              expect(errorLogger.errors.count) == 1
            }

            it("should have key of 'test'") {
              expect(errorLogger.errors[0].key.value) == "test"
            }

            context("publish another error") {
              beforeEach {
                let error = PublishableError(ErrorKey("test2"))
                errorPublisher.publish(error)
              }

              it("should have two errors in logger") {
                expect(errorLogger.errors.count) == 2
              }

              it("should have key of 'test2'") {
                expect(errorLogger.errors[1].key.value) == "test2"
              }
            }

            context("unsubscribe the logger") {
              beforeEach {
                errorPublisher.unsubscribe(errorLogger)
              }

              context("publish one error") {
                beforeEach {
                  let error = PublishableError(ErrorKey("test"))
                  errorPublisher.publish(error)
                }

                it("should still only have one error in logger") {
                  expect(errorLogger.errors.count) == 1
                }
              }
            }
          }
        }
      }
    }
  }
}
