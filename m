From: Thomas Renninger <trenn@suse.de>
Subject: Re: [RFC] Shutdown on thermal HOT event if no userspace tool registered being able to do S4
Date: Tue, 30 Mar 2010 17:31:01 +0100
Message-ID: <201003301831.01709.trenn@suse.de>
References: <4BB2BDA8020000230001594B@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:54424 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753670Ab0C3QbD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Mar 2010 12:31:03 -0400
In-Reply-To: <4BB2BDA8020000230001594B@novprvlin0050.provo.novell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joey Lee <jlee@novell.com>
Cc: rui.zhang@intel.com, hmacht@suse.de, rwysocki@suse.de, linux-acpi@vger.kernel.org

On Tuesday 30 March 2010 18:12:40 Joey Lee wrote:
> Hi Thomas,=20
>=20
> =E6=96=BC =E4=BA=8C=EF=BC=8C2010-03-30 =E6=96=BC 10:23 +0100=EF=BC=8C=
Thomas Renninger =E6=8F=90=E5=88=B0=EF=BC=9A
> > Hi,
=2E..
> > Comments?
> > What userspace tools are candidates to implement this if this
> > makes sense?
> >=20
>=20
> HAL + pm-util or DeviceKit-power might the candidates. But, if there
> have no those component in userland, what will acpi thermal module do=
?
> Direct shutdown?
> And, how can kernel space know userland can do this job well? Might w=
ait
> 10 seconds if system doesn't S4 or shutdown?
Yep, my idea is to e.g. provide:
/sys/class/thermal/S4_capable
By default you get:
cat /sys/class/thermal/S4_capable
0
and the thermal driver will call the same shutdown method
if the hot thermal tp is reached as if the critical is reached.

If pm-utils does:
echo 1 >/sys/class/thermal/S4_capable
it has to make sure it picks up acpi thermal hot event and initiates
S4. If S4 fails for whatever reasons (no swap,
stroking some kernel drivers fails, unmounting file systems fails, ...)=
,
it has to make sure to force a system shutdown (just call /sbin/powerof=
f
the same way the kernel does currently with a critical thermal event?).
Emergency shutdown is then out of kernels hand (as it is currently for =
HOT
anyway which is dangerous).

Hmm, this is acpi specific, possibly it should be a new dir here:
/sys/firmware/acpi/thermal/S4_capable
or something else?

    Thomas
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
