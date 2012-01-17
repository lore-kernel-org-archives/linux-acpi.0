From: Lin-Bao Zhang <2004.zhang@gmail.com>
Subject: how to Identify and determine NMI sourcing in GHES.c ? for example ,
 knowing a NMI error is caused by pcie error
Date: Tue, 17 Jan 2012 11:17:42 +0800
Message-ID: <CANuKePk9LWEuFe3zrh0RiKtau85DAEBHbd+Qow10Py80xzYYtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:44917 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758Ab2AQDRo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Jan 2012 22:17:44 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, ying.huang@intel.com, yanmin.zhang@intel.com
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@zh-kernel.org

I am sorry again, my last email can't be sent to LKML and acpi mailing
list successfully maybe due to not pure text format , so I resent it
again with pure text format .

thanks very much!

I just want to know , in upstream linux kernel ,can we know NMI
sourcing when NMI occurs ?


------------------------------------------------
Hi Huang and Bjorn,
> In firmware first mode (BIOS hold AER service control), AER will be r=
eported via> APEI HEST Generic Hardware Error Source, AER will be logge=
d by kernel there.> AER recovery can be triggered there too, but the co=
de has not been merged by> Linux kernel upstream yet.> > Best Regards,>=
 Huang Ying> In GHES.c : I saw this function :
static struct notifier_block ghes_notifier_nmi =3D {
=2Enotifier_call =3D ghes_notify_nmi,};......
//here ,there is a NMI handler specially for NMI . case
ACPI_HEST_NOTIFY_NMI:                  mutex_lock(&ghes_list_mutex);
               if (list_empty(&ghes_nmi))
register_die_notifier(&ghes_notifier_nmi);          ..........
a)	Now , I have one question about GHES.c can differ NMI sourcing ?
You know ,some sources can trigger NMI , how to know which is the
source ? for example ,memory corrupted or pcie error ? Especially ,
for PCIe error ,we want to do more works.
If we know NMI sourcing , we can do more works . for different NMI
errors , different actions should be taken, certainly , they should
have the same parts : reboot the machine at last.b)	Your code is
developing now ? what is your plan to submit them ? c)	In
ghes_notify_nmi() , can we add a code to differ NMI sourcing ?
differing NMI sourcing is of vendor's issue ? our HP's proliant
provide a driver "hpwdt.c" to check NMI sourcing by using CRU
interface on pre-Gen8 machine.
What is the relationship between GHES and HEST (table) ? I feel , HEST
is just table , GHES is just method : all error information are stored
HEST table by firmware , GHES is just firmware interface which is used
to expose to OSPM to parse this table.What is meaning of "general" in
"GHES" ? I guess , this presents common code , vendor needs to
implement its own method to hook after general code ? For example ,for
HP's machine , we must implement a special code for our HP's machine
to get error source ?

d)	http://lwn.net/Articles/368119/ , you said that :APEI stands for
ACPI Platform Error Interface, which allows to reporterrors (for
example from chipset) to the operating system. Thisimproves NMI
handling especially. In addition it supports errorserialization and
error injection.    Why did you say "This improves NMI handling
especially." ? How do HEST and GHES improve NMI handling ? Could you
share your comments ? thanks very much!

e)	About the SourceID and NMIerror :About how to identify the
NMIsourcing, following is my some thinking ,
=46rom ACPI spec :ACPI 5.0   from 18.3.2.6 Generic Hardware Error Sourc=
e
It seems that NMI handler should read the error status block to know
error source . from 18.4 Firmware First Error HandlingIt seems that
NMI handler can know the original source ID , but through this source
ID ,for example ,we can know this error is of pci error or other error
? It seems that what we can use to identify NMI source is just source
ID ?
In   rom 18.4.1 Example: Firmware First Handling Using NMI Notification
I feel that our ghes_notify_nmi () should do similar works just like
"OSPM NMI handler scans the list of generic error sources to find the
error source that reported the error and processes the error report"
thanks very much for your reply, I am sorry for my poor English .

-- Bob"=D7=D3=D4=BB=A3=BA=B2=BB=BB=BC=C8=CB=D6=AA=B2=BB=BC=BA=D6=AA,=BB=
=BC=B2=BB=D6=AA=C8=CB=D2=B2"If not us, who ? if not now, when ?"
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
