From: sasa bogicevic <brutallesale@gmail.com>
Subject: Re: [PATCH] drivers:pci Fix all whitespace issues
Date: Sun, 27 Dec 2015 18:56:16 +0100
Message-ID: <E354C470-6475-40AF-B08B-22AFF8B00C93@gmail.com>
References: <1451234408-42250-1-git-send-email-brutallesale@gmail.com> <1451236894.1098.5.camel@perches.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36794 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751463AbbL0R4U convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 27 Dec 2015 12:56:20 -0500
In-Reply-To: <1451236894.1098.5.camel@perches.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: bhelgaas@google.com, Richard.Zhu@freescale.com, l.stach@pengutronix.de, rjw@rjwysocki.net, lenb@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Hi Joe,
No this is not done with checkpatch.pl I just used it to verify that my=
 changes are correct. I was wondering why that =E2=80=9Ctype=E2=80=9D p=
ointer threw errors since it looks fine to me the way it was declared. =
This =E2=80=9Ctype*=E2=80=9D is just present in few of the files I can =
just redo those changes and send the patch again.

Thanks, Sasa
{
	name: Bogicevic Sasa
	phone: +381606006200
}



> On Dec 27, 2015, at 18:21, Joe Perches <joe@perches.com> wrote:
>=20
> On Sun, 2015-12-27 at 08:40 -0800, Bogicevic Sasa wrote:
>> This patch fixes all whitespace issues( missing or needed whitespace=
) in
>> all files in drivers/pci folder. Code is compiled with allyesconfig
>> before and after code changes and objects are recorded and checked w=
ith
>> objdiff and they are not changed after this commit.
> []
>> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> []
>> @@ -25,9 +25,9 @@ DEFINE_RAW_SPINLOCK(pci_lock);
>>  #define PCI_word_BAD (pos & 1)
>>  #define PCI_dword_BAD (pos & 3)
>> =20
>> -#define PCI_OP_READ(size,type,len) \
>> +#define PCI_OP_READ(size, type, len) \
>>  int pci_bus_read_config_##size \
>> -	(struct pci_bus *bus, unsigned int devfn, int pos, type *value)	\
>> +	(struct pci_bus *bus, unsigned int devfn, int pos, type * value)	\
>>  {									\
>>  	int res;							\
>>  	unsigned long flags;						\
>> @@ -40,7 +40,7 @@ int pci_bus_read_config_##size \
>>  	return res;							\
>>  }
>=20
> When the first entry I look at is improper, I wonder
> about the rest.
>=20
> Was this done with checkpatch --types=3Dspacing --fix ?
>=20
> If so, because checkpatch is brainless, you need to
> visually verify each change.
>=20
> This "type" use is a macro argument indicating
> what actual c90 type is being used in a function.
>=20
> The original code is nominally correct, but checkpatch
> doesn't know that "type" is not a variable.

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
