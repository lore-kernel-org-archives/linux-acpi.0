From: Ducrot Bruno <poup@poupinou.org>
Subject: Re: [ACPI] RE: Toshiba ACPI battery status - ACPI errors
Date: Tue, 25 Nov 2003 11:47:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20031125104748.GB7375@poupinou.org>
References: <7F740D512C7C1046AB53446D37200173618752@scsmsx402.sc.intel.com> <20031124225539.GA22718@fqdn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20031124225539.GA22718@fqdn.org>
To: Michael Holzt <kju@fqdn.org>
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Developers <acpi-devel@lists.sourceforge.net>, "Brown, Len" <len.brown@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Mon, Nov 24, 2003 at 11:55:39PM +0100, Michael Holzt wrote:
> > I suspect this is a known issue with AML code from Toshiba. 
> 
> Sorry, but unfortunately your guess is wrong (would have been too easy). A
> few days ago i reported about the Tecra S1 problems on the acpi-devel list
> as well, maybe you missed my post, which can be found in the archives here:
> 
>   http://sourceforge.net/mailarchive/forum.php?thread_id=3511931&forum_id=6102

Sorry, I missed your post.

> 
> Included was a link to the disassembled dsdt, which can be found here:
> 
>   http://www.kju.de/data/dsdt.dsl
> 
> As you can see, the _STA-Methods of both BAT0 and BAT1 do proper return
> calls. I'm sorry, but i'm do not have any knowledge about acpi or dsdts to
> debug this myself. The DSDT has some other errors as well.

I posted last week at acpi-devel a patch which fake a ECDT.  That should
at least fix your embedded error you encounter.

http://sourceforge.net/mailarchive/message.php?msg_id=6561311

Looking your DSDT, the parameter you have to pass at boot are:

ecdt_fake=0x66:0x62:0x10:-1:\\_SB.PCI0.LPCB.EC0

I hope that at least that will correct some obivous errors.

> 
> It is somewhat strange, that toshiba as one of the core members of ACPI
> seems to be unable to provide sane DSDTs for years now. Something is real
> wrong with this company.

Indeed.  They should change their ODM.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
