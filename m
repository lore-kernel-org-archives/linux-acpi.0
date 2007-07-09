From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: Re: add powerbutton and lid platform devices
Date: Mon, 9 Jul 2007 10:36:10 -0600
Message-ID: <20070709163610.GG31533@cosmic.amd.com>
References: <20070330235759.GC4252@cosmic.amd.com>
	<20070708221027.GA4964@dmt> <20070709150545.GD31533@cosmic.amd.com>
	<200707090930.26973.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@lists.laptop.org>
In-Reply-To: <200707090930.26973.david-b@pacbell.net>
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
To: David Brownell <david-b@pacbell.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, devel@laptop.org
List-Id: linux-acpi@vger.kernel.org

On 09/07/07 09:30 -0700, David Brownell wrote:
> > Lid behavior is so policy  
> > driven, I think we should leave it off by default, and let the power manager
> > decide what to do.
> 
> What's this "power manager" component?
> 
> This policy is easily set through sysfs.  It doesn't need a new
> component to make that decision.

I'm talking about OHM for userspace policy decisions.  But you are
correct.  It all boils down to a single sysfs knob for the kernel.
Nothing more is needed.

Jordan

-- 
Jordan Crouse
Systems Software Development Engineer 
Advanced Micro Devices, Inc.
