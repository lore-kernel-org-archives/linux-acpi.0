From: Daniel Exner <dex@dragonslave.de>
Subject: Re: linux-next Regression: Unable to locate IOAPIC
Date: Fri, 6 Jun 2008 19:30:28 +0200
Message-ID: <200806061930.29046.dex@dragonslave.de>
References: <200806051100.12885.dex@dragonslave.de> <20080606031718.36cbbdc9.akpm@linux-foundation.org>
Reply-To: webmaster@dragonslave.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20080606031718.36cbbdc9.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-next-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Andrew Morton wrote:
> (cc linux-acpi)
>
> On Thu, 5 Jun 2008 11:00:12 +0200 Daniel Exner <dex@dragonslave.de> wrote:
> > Hi!
> >
> > (Added myself to CC, because I'm not subscribed)
> >
> > with linux-next snapshot 20080604 my Laptop morphes into sitting duck and
> > I think this is due to this:
>
> I assume 2.6.26-rc5 is OK?
Indeed.. just tried it with (nearly) the same config: no unable to locate 
IOAPIC

Will try todays next snapshot above -rc5 now.

BTW: Any chance to get this damn thing to not route everything by IRQ 11 !?

Greetings
Daniel Exner
