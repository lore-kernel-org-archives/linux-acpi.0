From: David Mosberger <davidm-o/PNRNCSakrWxDs0y9d3MAC/G2K4zDHf@public.gmane.org>
Subject: Re: [PATCH] Introduce pci_raw_ops
Date: Thu, 19 Jun 2003 12:30:31 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <16114.3927.291190.349794@napali.hpl.hp.com>
References: <20030619191859.GF24357@parcelfarce.linux.theplanet.co.uk>
Reply-To: davidm-sDzT885Ts8HQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030619191859.GF24357-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, David Mosberger <davidm-sDzT885Ts8HQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

>>>>> On Thu, 19 Jun 2003 20:18:59 +0100, Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org> said:

  Matthew>  - Introduce pci_raw_ops - Convert all x86 & ia64 pci_ops
  Matthew> to implement & use it - Convert acpi code to use it

  Matthew> I've booted it on a generic K6 box.

diff -u -p -r1.8 pci.c
--- a/arch/ia64/pci/pci.c	14 Jun 2003 22:14:34 -0000	1.8
+++ a/arch/ia64/pci/pci.c	19 Jun 2003 19:11:48 -0000

-struct pci_ops *pci_root_ops = &pci_sal_ops;	/* default to SAL */
+struct pci_ops *pci_root_ops = {
+	.read = pci_read,
+	.write = pci_write,
+}

Does this really compile?

	--david


-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
