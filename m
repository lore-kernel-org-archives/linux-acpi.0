From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: PATCH: Call acpi_leave_sleep_state before resuming devices
Date: Mon, 10 Jan 2005 10:19:55 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD30575F054DA@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stefan D?singer <stefandoesinger-RbZlAiThDcE@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004-hi6Y0CQ0nG0@public.gmane.org>, Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

>
>Here's again the resume-finish-split patch, this time CC-ed to Len.
>
>This patch splits up acpi_pm_leave. It introduces acpi_pm_leave which
calls
>acpi_leave_sleep_state and acpi_disable_wakeup_device before resuming
the
>devices. This improves S3 resume on an Acer Travelmate 800 and on the
>Samsung
>P3 notebook.
>
>Some archive references:
>http://sourceforge.net/mailarchive/message.php?msg_id=3D9091506
>http://sourceforge.net/mailarchive/message.php?msg_id=3D10315947
>
>The background is that any write access to the pci config registers of
some
>devices(sound card, usb 2.0 controler, and modem) cause a system lockup
if
>they are called before acpi_leave_sleep_state and
>acpi_disable_wakeup_device
>were called. This is on an Acer Travelmate 803 Notebook, and it seems
to be
>the same on other systems.
>
>I sent the patch to the list, but it seems that nobody noticed it and I
>forgot
>to send it again. Here is an updated patch against 2.6.10. I can't
promise
>that it doesn't break other systems. Someone should make sure that
>pm_ops->leave is set to NULL for apm. I haven't found this in the apm
code
>yet.
ACPI spec also said _PTS (in 'acpi_enter_sleep_state_prep') should be
called after all devices are suspend (ACPI sepc 3.0 P401), could you
please also change the order of device suspend and
'acpi_enter_sleep_state_prep'?

Thanks,
Shaohua


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
