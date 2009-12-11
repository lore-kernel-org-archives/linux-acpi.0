From: Jes Sorensen <jes.sorensen@gmail.com>
Subject: Re: PATCH: Toshiba Bluetooth enabler (v3)
Date: Fri, 11 Dec 2009 11:51:18 +0100
Message-ID: <4B222426.8000904@gmail.com>
References: <4B192D08.9080608@gmail.com>	 <9b2b86520912080205x478b47eek2377dacdbe44a522@mail.gmail.com>	 <4B1E85A9.3030005@gmail.com>	 <9b2b86520912090517l458bc21cobbb138d460e11f53@mail.gmail.com>	 <4B211346.2000205@gmail.com> <9b2b86520912100900p5796bc35q702af615d3f27a0c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761013AbZLKKu7@vger.kernel.org>
In-Reply-To: <9b2b86520912100900p5796bc35q702af615d3f27a0c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, lenb@kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>
List-Id: linux-acpi@vger.kernel.org

On 12/10/09 18:00, Alan Jenkins wrote:
> I did question "depends on RFKILL".  If you manually configure a
> kernel, you will miss "If you have a modern Toshiba laptop with a
> Bluetooth and an RFKill switch (such as the Portege R500), say Y."
> unless you enable RFKILL first.  (Which is unnecessary since the
> driver will work exactly the same with RFKILL=n).  I wouldn't call it
> a strong objection, but it would be nice to hear the reason you
> included this dependency.
>
> Everything else looks fine.  Thanks for working on this.
> Alan

The driver is acting as RFKill functionality, even if it doesn't
provide it in full. We can pull that depend if you like, however
I still think it's awkward to offer a driver for a functionality
the user had previously said no to.

Cheers,
Jes
