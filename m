From: Florian Mickler <florian@mickler.org>
Subject: Re: [PATCH] x86, ioapic: move acpi_get_override_irq to acpi.c
Date: Sun, 3 Apr 2011 16:34:49 +0200
Message-ID: <20110403163449.33a6a4dc@schatten.dmk.lab>
References: <20110401075011.GD7594@elte.hu>
	<1301672686-10096-1-git-send-email-florian@mickler.org>
	<20110401182653.340abaa4@schatten.dmk.lab>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110401182653.340abaa4@schatten.dmk.lab>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Florian Mickler <florian@mickler.org>, mingo@elte.hu, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, kurup_avinash@yahoo.com, maciej.rutecki@gmail.com, rjw@sisk.pl, sedat.dilek@gmail.com
List-Id: linux-acpi@vger.kernel.org

On Fri, 1 Apr 2011 18:26:53 +0200
Florian Mickler <florian@mickler.org> wrote:

> And how do I check compilation of !CONFIG_X86_IO_APIC?  

That was a real question, btw. Not just me mumbling around... make
oldconfig always turns that symbol back on to =y ... and I couldn't find
out why. 

> Regards,
> Flo
