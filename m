From: David Brownell <david-b@pacbell.net>
Subject: Re: 2.6.25 regression: powertop says 120K wakeups/sec
Date: Fri, 28 Mar 2008 16:36:03 -0700
Message-ID: <200803281636.04029.david-b@pacbell.net>
References: <20080322202454.9D69DCC0EF@adsl-69-226-248-13.dsl.pltn13.pacbell.net> <200803281509.23107.david-b@pacbell.net> <20080328225604.GA7136@linux-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758206AbYC1XgV@vger.kernel.org>
In-Reply-To: <20080328225604.GA7136@linux-os.sc.intel.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Venki Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Friday 28 March 2008, Venki Pallipadi wrote:

> I think I figured out the bug...
> 
> Can you try the below patch and confirm that it works (over upstream - ignore
> the earlier revert patch I sent to you).

That seems to do the job ... thanks!  One more regression
fixed, it feels like RC7 is almost done. :)

It still says odd things about C0 vs C1 though:  powertop
says 100% of the time is in C0, but this patch would seem
to be irrelevant if that were true.

- Dave
