From: "Kok, Auke" <auke-jan.h.kok@intel.com>
Subject: Re: [BUG] long freezes on thinkpad t60
Date: Thu, 24 May 2007 15:13:24 -0700
Message-ID: <46560E04.2090500@intel.com>
References: <E1HrC3W-0005SZ-00@dorka.pomaz.szeredi.hu> <20070524220816.GC23214@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756432AbXEXWN4@vger.kernel.org>
In-Reply-To: <20070524220816.GC23214@khazad-dum.debian.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, mingo@elte.hu, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Henrique de Moraes Holschuh wrote:
> On Thu, 24 May 2007, Miklos Szeredi wrote:
>> Tried nmi_watchdog=1, but then the machine locks up hard shortly after
>> boot.
> 
> NMIs in some thinkpads are bad trouble, they lock up the blasted IBM/Lenovo
> SMBIOS if they happen to hit it while it is servicing a SMI, and thinkpads
> do SMIs like crazy.

there's also a L1 ASPM issue with the e1000 chipset in the way (for T60/X60 
only). Make sure you are using 2.6.21 or newer. See netdev archives for more on 
that.

Auke
