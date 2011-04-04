From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] x86, ioapic: move acpi_get_override_irq to acpi.c
Date: Mon, 4 Apr 2011 17:00:35 +0200
Message-ID: <20110404150035.GB11475@elte.hu>
References: <20110401075011.GD7594@elte.hu>
 <1301672686-10096-1-git-send-email-florian@mickler.org>
 <20110401182653.340abaa4@schatten.dmk.lab>
 <20110403163449.33a6a4dc@schatten.dmk.lab>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110403163449.33a6a4dc@schatten.dmk.lab>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Mickler <florian@mickler.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, kurup_avinash@yahoo.com, maciej.rutecki@gmail.com, rjw@sisk.pl, sedat.dilek@gmail.com
List-Id: linux-acpi@vger.kernel.org


* Florian Mickler <florian@mickler.org> wrote:

> On Fri, 1 Apr 2011 18:26:53 +0200
> Florian Mickler <florian@mickler.org> wrote:
> 
> > And how do I check compilation of !CONFIG_X86_IO_APIC?  
> 
> That was a real question, btw. Not just me mumbling around... make
> oldconfig always turns that symbol back on to =y ... and I couldn't find
> out why. 

'make ARCH=i386 allnoconfig' for example.

Thanks,

	Ingo
