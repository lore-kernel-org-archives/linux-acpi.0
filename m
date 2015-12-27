From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] drivers:pci Fix all whitespace issues
Date: Sun, 27 Dec 2015 09:21:34 -0800
Message-ID: <1451236894.1098.5.camel@perches.com>
References: <1451234408-42250-1-git-send-email-brutallesale@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtprelay0108.hostedemail.com ([216.40.44.108]:39326 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752871AbbL0RVj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 27 Dec 2015 12:21:39 -0500
In-Reply-To: <1451234408-42250-1-git-send-email-brutallesale@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bogicevic Sasa <brutallesale@gmail.com>, bhelgaas@google.com
Cc: Richard.Zhu@freescale.com, l.stach@pengutronix.de, rjw@rjwysocki.net, lenb@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Sun, 2015-12-27 at 08:40 -0800, Bogicevic Sasa wrote:
> This patch fixes all whitespace issues( missing or needed whitespace)=
 in
> all files in drivers/pci folder. Code is compiled with allyesconfig
> before and after code changes and objects are recorded and checked wi=
th
> objdiff and they are not changed after this commit.
[]
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
[]
> @@ -25,9 +25,9 @@ DEFINE_RAW_SPINLOCK(pci_lock);
> =A0#define PCI_word_BAD (pos & 1)
> =A0#define PCI_dword_BAD (pos & 3)
> =A0
> -#define PCI_OP_READ(size,type,len) \
> +#define PCI_OP_READ(size, type, len) \
> =A0int pci_bus_read_config_##size \
> -	(struct pci_bus *bus, unsigned int devfn, int pos, type *value)	\
> +	(struct pci_bus *bus, unsigned int devfn, int pos, type * value)	\
> =A0{									\
> =A0	int res;							\
> =A0	unsigned long flags;						\
> @@ -40,7 +40,7 @@ int pci_bus_read_config_##size \
> =A0	return res;							\
> =A0}

When the first entry I look at is improper, I wonder
about the rest.

Was this done with checkpatch --types=3Dspacing --fix ?

If so, because checkpatch is brainless, you need to
visually verify each change.

This "type" use is a macro argument indicating
what actual c90 type is being used in a function.

The original code is nominally correct, but checkpatch
doesn't know that "type" is not a variable.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
