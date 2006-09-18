From: "Dmitry Torokhov" <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [gpm] Untangling the sleep hotkey mess
Date: Mon, 18 Sep 2006 11:17:34 -0400
Message-ID: <d120d5000609180817h32e8dafavd5657f69a7d7a725@mail.gmail.com>
References: <CFF307C98FEABE47A452B27C06B85BB601614F5A@hdsmsx411.amr.corp.intel.com>
	<200608302253.43784.dtor@insightbb.com>
	<200608302303.38458.len.brown@intel.com>
	<200608302307.58511.dtor@insightbb.com>
	<1158566150.2332.14.camel@hughsie-laptop.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <gnome-power-manager-list-bounces-rDKQcyrBJuzYtjvyW6yDsg@public.gmane.org>
In-Reply-To: <1158566150.2332.14.camel-Qvr7v16j6+Ap96r9Hs7rR1Kr0EmMEXJSn9A1Ff6Mc9Q@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://mail.gnome.org/mailman/listinfo/gnome-power-manager-list>,
	<mailto:gnome-power-manager-list-request-rDKQcyrBJuzYtjvyW6yDsg@public.gmane.org?subject=unsubscribe>
List-Archive: </archives/gnome-power-manager-list>
List-Post: <mailto:gnome-power-manager-list-rDKQcyrBJuzYtjvyW6yDsg@public.gmane.org>
List-Help: <mailto:gnome-power-manager-list-request-rDKQcyrBJuzYtjvyW6yDsg@public.gmane.org?subject=help>
List-Subscribe: <http://mail.gnome.org/mailman/listinfo/gnome-power-manager-list>,
	<mailto:gnome-power-manager-list-request-rDKQcyrBJuzYtjvyW6yDsg@public.gmane.org?subject=subscribe>
Sender: gnome-power-manager-list-bounces-rDKQcyrBJuzYtjvyW6yDsg@public.gmane.org
Errors-To: gnome-power-manager-list-bounces-rDKQcyrBJuzYtjvyW6yDsg@public.gmane.org
To: richard-DRAXeJJ+PL1BDgjK7y7TUQ@public.gmane.org
Cc: desktop_portables-qjLDD68F18O7TbgM5vRIOg@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gnome-power-manager-list-rDKQcyrBJuzYtjvyW6yDsg@public.gmane.org, "Yu,  Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, hal-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On 9/18/06, Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Wed, 2006-08-30 at 23:07 -0400, Dmitry Torokhov wrote:
> > On Wednesday 30 August 2006 23:03, Len Brown wrote:
> > > On Wednesday 30 August 2006 22:53, Dmitry Torokhov wrote:
> > >
> > > > So... do you want me to make it work with !CONFIG_INPUT or shoudl I just
> > > > add a dependency on INPUT in Kconfig for button driver?
> > >
> > > If virtually everybody uses INPUT, then I'm fine with the ACPI button driver simply depending
> > > on CONFIG_INPUT.
> > >
> > > If nobody uses ACPI on a system without INPUT, then I don't see why we should
> > > muck up the code to suport a case that nobody will test or use.
> > >
> >
> > INPUT is not used on s390 but I suppose that's ok ;) You need to work
> > really hard to disable input (embedded, no VTs or anything, etc).
>
> Is there any feedback on this solution? Also, what's the timescale for
> conversion to the input layer - are we talking blue sky or a few months?
> I want to make sure userspace is in a position for this change.
>

I sent the updated patch to Yu Luming, the copy is in the list archives:

http://marc.theaimsgroup.com/?l=linux-acpi&m=115751976924048&w=2

so unless there are objections to the thing I'd like to have it
applied to ACPI tree.

-- 
Dmitry
