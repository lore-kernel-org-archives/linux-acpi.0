From: Richard Hughes <hughsient@gmail.com>
Subject: Re: [gpm] Untangling the sleep hotkey mess
Date: Mon, 18 Sep 2006 08:55:50 +0100
Message-ID: <1158566150.2332.14.camel@hughsie-laptop.localdomain>
References: <CFF307C98FEABE47A452B27C06B85BB601614F5A@hdsmsx411.amr.corp.intel.com>
	<200608302253.43784.dtor@insightbb.com>
	<200608302303.38458.len.brown@intel.com>
	<200608302307.58511.dtor@insightbb.com>
Reply-To: richard@hughsie.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <hal-bounces@lists.freedesktop.org>
In-Reply-To: <200608302307.58511.dtor@insightbb.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/hal>,
	<mailto:hal-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/hal>
List-Post: <mailto:hal@lists.freedesktop.org>
List-Help: <mailto:hal-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/hal>,
	<mailto:hal-request@lists.freedesktop.org?subject=subscribe>
Sender: hal-bounces@lists.freedesktop.org
Errors-To: hal-bounces@lists.freedesktop.org
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, desktop_portables@lists.osdl.org, gnome-power-manager-list@gnome.org, hal@lists.freedesktop.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2006-08-30 at 23:07 -0400, Dmitry Torokhov wrote:
> On Wednesday 30 August 2006 23:03, Len Brown wrote:
> > On Wednesday 30 August 2006 22:53, Dmitry Torokhov wrote:
> > 
> > > So... do you want me to make it work with !CONFIG_INPUT or shoudl I just
> > > add a dependency on INPUT in Kconfig for button driver?
> > 
> > If virtually everybody uses INPUT, then I'm fine with the ACPI button driver simply depending
> > on CONFIG_INPUT.
> > 
> > If nobody uses ACPI on a system without INPUT, then I don't see why we should
> > muck up the code to suport a case that nobody will test or use.
> > 
> 
> INPUT is not used on s390 but I suppose that's ok ;) You need to work
> really hard to disable input (embedded, no VTs or anything, etc).

Is there any feedback on this solution? Also, what's the timescale for
conversion to the input layer - are we talking blue sky or a few months?
I want to make sure userspace is in a position for this change.

Thanks for all your help,

Richard.
