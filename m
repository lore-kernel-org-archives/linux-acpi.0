From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: 2.6.21-mm2: ACPI exception on resume
Date: Wed, 23 May 2007 14:13:30 -0300
Message-ID: <20070523171330.GB9987@khazad-dum.debian.net>
References: <20070519165738.GK11115@waste.org> <20070523001943.GA3743@khazad-dum.debian.net> <20070523014825.GX11115@waste.org> <200705231057.48320.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S935729AbXEWRNz@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200705231057.48320.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matt Mackall <mpm@selenic.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 23 May 2007, Rafael J. Wysocki wrote:
> While I agree with that, it would really be helpful if you tested the latest -rc
> kernel and saw if the bug was present in there.
> 
> If the bug is not present in the latest -rc, it'll be possible to identify the
> patch that causes it to appear in -mm and find the reason of the breakage.

And, once we know the reason, we will be able to find out how to best fix the
problem.

So, do please test latest -rc, or bissect to the last known-good kernel. As
I said, we need further data points to do anything.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
