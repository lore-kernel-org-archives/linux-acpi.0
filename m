From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [ACPI] [PATCH] remove 55 dead prototypes from include/acpi/acdisasm.h
Date: Wed, 21 Jul 2004 13:30:29 -0700
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <37F890616C995246BE76B3E6B2DBE055017355C4@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S266616AbUGUUgP@vger.kernel.org>
Content-class: urn:content-classes:message
To: Carl Spalletta <cspalletta@yahoo.com>, lkml <linux-kernel@vger.kernel.org>
Cc: en.brown@intel.com, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

These aren't nonexistent functions, they are part of the AML
disassembler (which is not always configured into the kernel)




> -----Original Message-----
> From: acpi-devel-admin@lists.sourceforge.net [mailto:acpi-devel-
> admin@lists.sourceforge.net] On Behalf Of Carl Spalletta
> Sent: Tuesday, July 20, 2004 4:05 PM
> To: lkml
> Cc: en.brown@intel.com; acpi-devel@lists.sourceforge.net
> Subject: [ACPI] [PATCH] remove 55 dead prototypes from
> include/acpi/acdisasm.h
> 
> This patch removes 55 prototypes of nonexistent functions.
> 
> N.B.
>  Due to my inability to cut and paste the tab chars embedded in file
to be
> patched (they are
>  picked up as sequences of spaces), you must either a) 'unexpand
--first-
> only' the enclosed patch
>  to recover the tab chars from the original file, or b) apply with
'patch
> --ignore-whitespace'.
>  The latter option can't hurt since we are only removing lines from
the
> file, not adding.
> 
> Signed-off-by: Carl Spalletta <cspalletta@yahoo.com>
> 
> diff -ru /usr/src/linux-2.6.7-orig/include/acpi/acdisasm.h
> /usr/src/linux-2.6.7-new/include/acpi/acdisasm.h
> --- /usr/src/linux-2.6.7-orig/include/acpi/acdisasm.h   2004-06-15
> 22:19:26.000000000 -0700
> +++ /usr/src/linux-2.6.7-new/include/acpi/acdisasm.h    2004-07-18
> 20:10:42.000000000 -0700
> @@ -86,317 +86,14 @@
>         u32                                 level,
>         void                                *context);
> 
