From: Frank Mehnert <fm3-IG//nw+yl+iQIjdd1DhZXWfrygkm6VTR@public.gmane.org>
Subject: Re: VMware and ACPI
Date: Tue, 16 Sep 2003 11:00:52 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200309161100.52454.fm3@os.inf.tu-dresden.de>
References: <m2k789sotw.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_EFtZ/srDIDM9mOp"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <m2k789sotw.fsf-dTJq59+VGzkkCw8IV3R6h0EOCMrvLtNR@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jan Rychter <jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--Boundary-00=_EFtZ/srDIDM9mOp
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 15 September 2003 23:51, Jan Rychter wrote:
> Hmm... just wondering: what happened to the VMware/ACPI interaction
> issues that some people were reporting here?
>
> There were some discussions and it seemed that ACPI idling the processor
> while VMware really wanted to use it was the cuplrit. Any resulting
> changes?
>
> I'm running 2.4.22-pre10 now and my WindowsXP inside VMware runs
> horribly slow. It gets considerably better if I leave an USB device
> plugged in (which causes ACPI to use C2 only and never go into C3), but
> it still isn't full speed.

Yes, there is still a problem. I use the appending patch since ages. Before
starting VMware, I do

  echo -n "0" > /proc/acpi/processor/CPU/power

and after VMware has terminated I do

  echo -n "1" > /proc/acpi/processor/CPU/power

This prevents ACPI from going into C2 while VMware is active. This solves
at least my problems (slow, bad response) with Windows NT on VMware. I'm
using Linux-2.4.22.

Frank
-- 
## Dept. of Computer Science, Dresden University of Technology, Germany ##
## http://os.inf.tu-dresden.de/~fm3                                     ##

--Boundary-00=_EFtZ/srDIDM9mOp
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="acpi_no_idle.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="acpi_no_idle.diff"

--- linux-2.4.22.orig/drivers/acpi/processor.c	Mon Aug 25 13:44:41 2003
+++ linux-2.4.22/drivers/acpi/processor.c	Tue Sep  9 22:31:39 2003
@@ -1677,6 +1677,37 @@
 
 
 static int
+acpi_processor_write_power (
+        struct file		*file,
+        const char		*buffer,
+        unsigned long		count,
+        void			*data)
+{
+	struct acpi_processor	*pr = (struct acpi_processor *) data;
+	char			state_string[2] = {'\0'};
+
+	if (!pr || (count > sizeof(state_string) - 1))
+		return_VALUE(-EINVAL);
+	
+	if (copy_from_user(state_string, buffer, count))
+		return_VALUE(-EFAULT);
+	
+	state_string[count] = '\0';
+
+	if (state_string[0] == '1') {
+	    printk(KERN_INFO PREFIX "enabling acpi idle\n");
+	    pm_idle = acpi_processor_idle;
+	} else {
+	    printk(KERN_INFO PREFIX "disabling acpi idle\n");
+	    pm_idle = pm_idle_save;
+	    acpi_processor_power_activate(pr, ACPI_STATE_C1);
+	}
+
+	return_VALUE(count);
+}
+
+
+static int
 acpi_processor_read_performance (
 	char			*page,
 	char			**start,
@@ -1982,6 +2013,7 @@
 			ACPI_PROCESSOR_FILE_POWER));
 	else {
 		entry->read_proc = acpi_processor_read_power;
+		entry->write_proc = acpi_processor_write_power;
 		entry->data = acpi_driver_data(device);
 	}
 

--Boundary-00=_EFtZ/srDIDM9mOp--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
