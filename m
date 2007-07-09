From: David Brownell <david-b@pacbell.net>
Subject: Re: add powerbutton and lid platform devices
Date: Mon, 9 Jul 2007 09:30:26 -0700
Message-ID: <200707090930.26973.david-b@pacbell.net>
References: <20070330235759.GC4252@cosmic.amd.com> <20070708221027.GA4964@dmt>
	<20070709150545.GD31533@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@lists.laptop.org>
In-Reply-To: <20070709150545.GD31533@cosmic.amd.com>
Content-Disposition: inline
List-Unsubscribe: <http://lists.laptop.org/listinfo/devel>,
	<mailto:devel-request@lists.laptop.org?subject=unsubscribe>
List-Archive: <http://lists.laptop.org/pipermail/devel>
List-Post: <mailto:devel@lists.laptop.org>
List-Help: <mailto:devel-request@lists.laptop.org?subject=help>
List-Subscribe: <http://lists.laptop.org/listinfo/devel>,
	<mailto:devel-request@lists.laptop.org?subject=subscribe>
Sender: devel-bounces@lists.laptop.org
Errors-To: devel-bounces@lists.laptop.org
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, devel@laptop.org
List-Id: linux-acpi@vger.kernel.org

On Monday 09 July 2007, Jordan Crouse wrote:

> I agree that the default setting for the power button should be to 
> wake up, but I don't know about the lid.  Imagine a scenario where somebody
> manually puts the machine to sleep and then shuts the lid.  You wouldn't want
> the machine to turn back on when you lifted it.

I wouldn't want "echo mem > /sys/power/state" to
automagically cause the lid to act strangely...


> Lid behavior is so policy  
> driven, I think we should leave it off by default, and let the power manager
> decide what to do.

What's this "power manager" component?

This policy is easily set through sysfs.  It doesn't need a new
component to make that decision.

- Dave
