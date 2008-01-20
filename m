From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: dmidecode from Dell Vostro 1000
Date: Sun, 20 Jan 2008 17:25:10 -0200
Message-ID: <20080120192510.GD19295@khazad-dum.debian.net>
References: <3a082f0c0711201915p3f10ec66mc6d8f024da8f363d@mail.gmail.com> <200801190138.53347.lenb@kernel.org> <3a082f0c0801190745k34ad76ddi83417ad56b08f0ee@mail.gmail.com> <200801201352.43845.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:43927 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754972AbYATTZO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 Jan 2008 14:25:14 -0500
Content-Disposition: inline
In-Reply-To: <200801201352.43845.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Jaakan Shorter <jaakanshorter@gmail.com>, linux-acpi@vger.kernel.org

On Sun, 20 Jan 2008, Len Brown wrote:
> > [    0.000000] BIOS-provided physical RAM map:
> > [    0.000000]  BIOS-e820: 0000000000000000 - 000000000009dc00 (usable)
> > [    0.000000]  BIOS-e820: 000000000009dc00 - 00000000000a0000 (reserved)
> > [    0.000000]  BIOS-e820: 00000000000ce000 - 0000000000100000 (reserved)
> > [    0.000000]  BIOS-e820: 0000000000100000 - 0000000037e70000 (usable)
> > [    0.000000]  BIOS-e820: 0000000037e70000 - 0000000037e80000 (ACPI data)
> 
>          OperationRegion (OSTY, SystemMemory, 0x37E80F06, 0x00000001)
>          Field (OSTY, AnyAcc, NoLock, Preserve)
>          {
>              TPOS,   8
>          }
> 
> Curious, Op-region OSTY sits in the (reclaimable) ACPI tables region
> in the e820 map.  I guess it is a good thing that Linux never calls
> the BIOS's bluff and reclaims that region after the tables are read
> (we leave the tables in place and use them there) -- because otherwise
> the OS could scribble on a region that is used by AML at run time.

Shouldn't such problems be added that as a test of firmware quality to the
linux firmware kit (if it doesn't catch such issues already), even if it
doesn't cause Linux breakage?

Anyone screwing up something so basic probably botched up other stuff as
well.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
