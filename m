From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: ACPI Error (utglobal-0126)
Date: Wed, 16 Jan 2008 09:38:14 +0800
Message-ID: <1200447494.2935.14.camel@acpi-sony.sh.intel.com>
References: <b43bf5490801150510v55ddb2feq3be947536c4c28c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:21774 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753197AbYAPBdM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Jan 2008 20:33:12 -0500
In-Reply-To: <b43bf5490801150510v55ddb2feq3be947536c4c28c5@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Erwan Velu <erwanaliasr1@gmail.com>
Cc: linux-acpi@vger.kernel.org

Hi,

On Tue, 2008-01-15 at 14:10 +0100, Erwan Velu wrote:
> Hey folks,
> 
> I'm running a 2.6.24-rc7 on my Samsung R70 in 64bit mode.
> While booting up, the ACPI shows me this error :
> 
> ACPI Error (utglobal-0126): Unknown exception code: 0xFFFFFFFE [20070126]
Hmm, return value is -ENOENT which means video bus failed to evaluated
the _ADR method of the video device.
Please open a bug at
http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
and assign it to me.
Please attach the dmesg output and acpidump as well.

> Pid: 1950, comm: modprobe Not tainted 2.6.24-laptop-0.rc7.1mdv #1
> 
> Call Trace:
>  [<ffffffff8038bd86>] acpi_ut_update_ref_count+0x50/0x9d
>  [<ffffffff8038c231>] acpi_format_exception+0x2c/0x35
>  [<ffffffff8038afcb>] acpi_ut_exception+0x25/0x8c
>  [<ffffffff8037662c>] acpi_evaluate_integer+0xb6/0xc7
>  [<ffffffff8821dd0a>] :video:acpi_video_bus_add+0xcc9/0xce2
>  [<ffffffff802c45e8>] ifind+0x58/0xd0
>  [<ffffffff8038f33c>] acpi_device_probe+0x43/0x91
>  [<ffffffff803c31cc>] driver_probe_device+0x9c/0x1b0
>  [<ffffffff803c3499>] __driver_attach+0xc9/0xd0
>  [<ffffffff803c33d0>] __driver_attach+0x0/0xd0
>  [<ffffffff803c23ad>] bus_for_each_dev+0x4d/0x80
>  [<ffffffff803c281c>] bus_add_driver+0xac/0x220
>  [<ffffffff8822303c>] :video:acpi_video_init+0x3c/0x5e
>  [<ffffffff802622ae>] sys_init_module+0x18e/0x19a0
>  [<ffffffff802522b0>] autoremove_wake_function+0x0/0x30
>  [<ffffffff8020c34e>] system_call+0x7e/0x83
> 
> ACPI Exception (video-1721): UNKNOWN_STATUS_CODE, Cant attach device [20070126]
> input: Video Bus as /class/input/input7
> 
Please try this patch first.
From: Zhang Rui <rui.zhang@intel.com>

acpi_video_bus_get_one_device() is returning -errno style status,
but acpi_video_bus_get_devices() is expecting an ACPICA style status

Fix this and check the return value of acpi_video_device_enumerate as well.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/video.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

Index: linux-2.6/drivers/acpi/video.c
===================================================================
--- linux-2.6.orig/drivers/acpi/video.c
+++ linux-2.6/drivers/acpi/video.c
@@ -1530,7 +1530,7 @@ static int acpi_video_device_enumerate(s
 	status = acpi_evaluate_object(video->device->handle, "_DOD", NULL, &buffer);
 	if (!ACPI_SUCCESS(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _DOD"));
-		return status;
+		return -EIO;
 	}
 
 	dod = buffer.pointer;
@@ -1699,13 +1699,18 @@ acpi_video_bus_get_devices(struct acpi_v
 	int status = 0;
 	struct acpi_device *dev;
 
-	acpi_video_device_enumerate(video);
+	status = acpi_video_device_enumerate(video);
+	if (status) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				"Failed to enumerate devices\n"));;
+		return status;
+	}
 
 	list_for_each_entry(dev, &device->children, node) {
 
 		status = acpi_video_bus_get_one_device(dev, video);
-		if (ACPI_FAILURE(status)) {
-			ACPI_EXCEPTION((AE_INFO, status, "Cant attach device"));
+		if (status) {
+			ACPI_EXCEPTION((AE_INFO, AE_ERROR, "Cant attach device"));
 			continue;
 		}
 	}


