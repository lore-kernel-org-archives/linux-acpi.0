From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] battery: Fix charge_now returned by broken batteries
Date: Mon, 5 Oct 2009 00:43:56 +0200
Message-ID: <200910050043.56667.rjw@sisk.pl>
References: <1254669853.26496.0.camel@carter> <200910042246.23712.rjw@sisk.pl> <4AC91578.2020807@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757541AbZJDWng@vger.kernel.org>
In-Reply-To: <4AC91578.2020807@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sunday 04 October 2009, Alexey Starikovskiy wrote:
> Hi Rafael,

Alex,

> This is not my rule, it was/is the rule of power device class. If you do not agree to it, please change
> appropriate documentation.

I think we're talking about two different things.  One thing is that we
shouldn't put any _arbitrary_ interpretation rules into the kernel, which I
agree with.  The other one is that if there's a _known_ _broken_ hardware
and one possible way of handling it is to add a quirk into the kernel, we
should at least consider doing that.

In my opinion adding a quirk for a broken hardware is not equivalent to
"inferring not available properties using some heuristics or mathematical
model", if that's what you're referring to.

That said, the patch should not change the _default_ code in order to handle
the quirky hardware correctly.  IMO, the quirky hardware should be recognized
during initialisation, if possible, and later handled in a special way.  If
it's not possible to detect the broken hardware reliably, I agree that there's
nothing we can do about that in the kernel.

Thanks,
Rafael
