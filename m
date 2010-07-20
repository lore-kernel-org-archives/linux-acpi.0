From: akpm@linux-foundation.org
Subject: [patch 14/26] fujitsu-laptop: make needlessly global symbols static
Date: Tue, 20 Jul 2010 15:19:45 -0700
Message-ID: <201007202219.o6KMJjCZ021043@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: mjg59@srcf.ucam.org
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, akpm@linux-foundation.org, axel.lin@gmail.com, jwoithe@physics.adelaide.edu.au, mjg@redhat.com
List-Id: linux-acpi@vger.kernel.org

From: Axel Lin <axel.lin@gmail.com>

The following symbols are needlessly defined global:

logolamp_led
kblamps_led

This patch makes the symbols static.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
Cc: Matthew Garrett <mjg@redhat.com>
Acked-by: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/platform/x86/fujitsu-laptop.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/platform/x86/fujitsu-laptop.c~fujitsu-laptop-make-needlessly-global-symbols-static drivers/platform/x86/fujitsu-laptop.c
--- a/drivers/platform/x86/fujitsu-laptop.c~fujitsu-laptop-make-needlessly-global-symbols-static
+++ a/drivers/platform/x86/fujitsu-laptop.c
@@ -182,7 +182,7 @@ static enum led_brightness logolamp_get(
 static void logolamp_set(struct led_classdev *cdev,
 			       enum led_brightness brightness);
 
-struct led_classdev logolamp_led = {
+static struct led_classdev logolamp_led = {
  .name = "fujitsu::logolamp",
  .brightness_get = logolamp_get,
  .brightness_set = logolamp_set
@@ -192,7 +192,7 @@ static enum led_brightness kblamps_get(s
 static void kblamps_set(struct led_classdev *cdev,
 			       enum led_brightness brightness);
 
-struct led_classdev kblamps_led = {
+static struct led_classdev kblamps_led = {
  .name = "fujitsu::kblamps",
  .brightness_get = kblamps_get,
  .brightness_set = kblamps_set
_
