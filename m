From: Jeffrey Merkey <jeffmerkey@gmail.com>
Subject: Re: Linux 2.6.34 causes system lockup on Compaq Presario 2200 Laptop
Date: Fri, 11 Jun 2010 10:29:13 -0600
Message-ID: <AANLkTilrLYu6H3GtAcP-cHpFvrm3v22uCw2EUeW_ZK0k@mail.gmail.com>
References: <AANLkTil6GGSoc8TpzRacr1LZBZS3ee3H1ejYDSqfdul4@mail.gmail.com>
	<20100529202253.0bd18bbd.akpm@linux-foundation.org>
	<alpine.LFD.2.00.1006091821060.1402@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.1006091821060.1402@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Len,

I am having trouble getting a trace of this because its down hard to
reproduce.  The reason is the lockup happens before I log into the
laptop.  i.e. I boot 2.6.34 and if I let the laptop just sit there is
happens.  If I log in and start doing work on it, it does not seem to
happen.  It's related to using the laptop on battery mode with the
charger removed.  I have a 2U appliance setup I am working on today
and this frees up the laptop to try to reproduce this.  The flaky
battery power misreporting was in fact accurate.  The battery in that
laptop is 6 years old and does have low power.  I am certain the
lockup if related though.  I will try to reproduce today and setup the
trace to run after boot.  I have had it sitting there for an  hour and
it has not reoccurred.  Let me try through today and if I cannot
reproduce, close the bug.

Jeff

On Wed, Jun 9, 2010 at 4:21 PM, Len Brown <lenb@kernel.org> wrote:
> Jeff,
> Please attach the output of acpidump here:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=16136
>
> thanks,
> Len Brown, Intel Open Source Technology Center
>
