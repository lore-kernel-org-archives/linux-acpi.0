From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] ACPICA: Fix dispatcher timeout mechanism
Date: Tue, 16 Oct 2018 07:04:57 +0200
Message-ID: <20181016050457.GA6031@kroah.com>
References: <20181015221848.256323-1-bvanassche@acm.org>
 <CAJZ5v0jDv3ufH+MOXmrygHkBgu4CgT6DZL38xq1ViGiju8VxqQ@mail.gmail.com>
 <1539644495.129692.8.camel@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1539644495.129692.8.camel@acm.org>
Sender: stable-owner@vger.kernel.org
To: Bart Van Assche <bvanassche@acm.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, kbuild test robot <fengguang.wu@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Stable <stable@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Oct 15, 2018 at 04:01:35PM -0700, Bart Van Assche wrote:
> On Tue, 2018-10-16 at 00:44 +0200, Rafael J. Wysocki wrote:
> > On Tue, Oct 16, 2018 at 12:19 AM Bart Van Assche <bvanassche@acm.org> wrote:
> > > 
> > > This patch avoids that the following warning is reported during hibernation:
> > 
> > Well, what exactly is the problem and why is the patch the right way
> > to address it?
> 
> It is not safe to call ktime_get() after having called timekeeping_suspend().
> 
> > >  /*
> > > diff --git a/drivers/acpi/acpica/dscontrol.c b/drivers/acpi/acpica/dscontrol.c
> > > index 0da96268deb5..9dbea4549484 100644
> > > --- a/drivers/acpi/acpica/dscontrol.c
> > > +++ b/drivers/acpi/acpica/dscontrol.c
> > > @@ -84,8 +84,8 @@ acpi_ds_exec_begin_control_op(struct acpi_walk_state *walk_state,
> > >                 control_state->control.package_end =
> > >                     walk_state->parser_state.pkg_end;
> > >                 control_state->control.opcode = op->common.aml_opcode;
> > > -               control_state->control.loop_timeout = acpi_os_get_timer() +
> > > -                   (u64)(acpi_gbl_max_loop_iterations * ACPI_100NSEC_PER_SEC);
> > > +               control_state->control.loop_timeout = jiffies +
> > > +                   acpi_gbl_max_loop_iterations * HZ;
> > 
> > jiffies is Linux-specific and so it should not be used in the ACPICA code.
> 
> Really? There is plenty of other ACPI code that uses the jiffies counter directly.
> Why wouldn't it be allowed to use the jiffies counter in this context since there
> is so much other ACPI code that uses that counter?

acpica is different from acpi.  It is the "core acpi code" that is
shared across other operating systems.  That is why jiffies does not
work in it :(

thanks,

greg k-h
