From: matthieu castet <castet.matthieu-GANU6spQydw@public.gmane.org>
Subject: Re: [RFC/patch] ACPI in linux PnP layer
Date: Sun, 26 Sep 2004 20:17:32 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <415707BC.4000409@free.fr>
References: <16A54BF5D6E14E4D916CE26C9AD305752500E0@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD305752500E0-4yWAQGcml66iAffOGbnezLfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Li, Shaohua wrote:
> Greetings,
> I took a close look at your patch, so there are more comments. 
 > 1. I think _SRS stands PNP_CONFIGURABLE
 > 2. How about move the resource related code into another file, and
 > remove the global variable ('option_independent' and 'option')
 > 3. If an acpi device has an acpi driver, such as link device (PNP0c0f),
 > it must be out of the control of PNP driver. I'm considering add a list
 > for the devices.
 > For your todo list, I guess the item 'irq > 15' is not needed, since IRQ
 > of pnp device is always <15. Besides, I considering add more items into
 > the list. Such as, support PNP devices D-state (_PS0, and _PS3) and
 > devices specific method such as _FDI for floppy.
 > Please let me know your opinion.
 >

Hi,

I very sorry I couldn't reply earlier : I have been problems with my ISP 
since 2 weeks.

I am very glad you improve my patch and add dynamic configuration 
support and more.

I agree for 1,2,3.

For 3, perhaps a cleaner solution could be interaction between pnpacpi 
and "acpi bus" :
when an acpi driver register, it remove the PNP id it want from the PNP 
layer (fail if there are already a pnp driver that use the id).

And for the drivers that register before (pci_link if I remember), a 
flags could be added somewhere in acpi_device structure that tell the 
device is already registered by a driver.

This add also the advantage of removing conflict between driver that use 
acpi and those that use pnp for the same device(for example 8250_acpi.c 
and 8250_pnp.c) even if duplicate will be removed.

On the previous patch I send to the ML, I only change
dev->active = device->status.functional to dev->active = 
device->status.enabled that you have already done in your patch.

I also add a check for the pnpids : instead of testing in the length is 
7, I ckeck it verify [@-Z][@-Z][@-Z][0-9A-F][0-9A-F][0-9A-F][0-9A-F]\0 
regexp

For that I modify pnpidacpi_to_pnpid


+/*
+ * Compatible Device IDs
+ */
+#define TEST_HEX(c) if (!(('0' <= c && c <= '9') || ('A' <= c && c <= 
'F'))) \
+			return 0
+#define TEST_ALPHA(c) if (!('@' <= c || c <= 'Z')) \
+			return 0
+
+static int pnpidacpi_to_pnpid(char *id, char *str)
+{
+	TEST_ALPHA(id[0]);
+	str[0] = id[0];
+	TEST_ALPHA(id[1]);
+	str[1] = id[1];
+	TEST_ALPHA(id[2]);
+	str[2] = id[2];
+	TEST_HEX(id[3]);
+	str[3] = tolower(id[3]);
+	TEST_HEX(id[4]);
+	str[4] = tolower(id[4]);
+	TEST_HEX(id[5]);
+	str[5] = tolower(id[5]);
+	TEST_HEX(id[6]);
+	str[6] = tolower(id[6]);
+	if (id[7] != '\0')
+		return 0;
+	str[7] = '\0';
+
+	return 1;
+}

and in pnpacpi_add_device

+       if ((strlen(acpi_device_hid(device)) != 7) ||
+               is_exclusive_device(device))
+               return 0;
+
+       pnpidacpi_to_pnpid(acpi_device_hid(device), id);
become
+       if ((!pnpidacpi_to_pnpid(acpi_device_hid(device), id)) ||
+               is_exclusive_device(device))
+               return 0;
+



> Thanks,
> Shaohua
> 

Thanks,
Matthieu



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
