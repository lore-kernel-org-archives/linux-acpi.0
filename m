From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH -next] acpi/hmat: fix memory leaks in hmat_init()
Date: Tue, 9 Apr 2019 23:34:40 +0200
Message-ID: <CAJZ5v0jSutxp0jadaj3d2rR+2i4xX7BHaf6g0o_UDQ4-decw8g@mail.gmail.com>
References: <20190406181704.33574-1-cai@lca.pw> <CAJZ5v0jxUn_Hhm21FFBc2eSp49kCciCzR1_UGewHkpJiTy3LGw@mail.gmail.com>
 <1554816309.26196.46.camel@lca.pw> <CAJZ5v0g_oLdqv_sp8Un-44wO6vtQH6rVeUTKxSynO8VPPascxA@mail.gmail.com>
 <1554823996.26196.48.camel@lca.pw>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554823996.26196.48.camel@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
To: Qian Cai <cai@lca.pw>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Keith Busch <keith.busch@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Apr 9, 2019 at 5:33 PM Qian Cai <cai@lca.pw> wrote:
>
> On Tue, 2019-04-09 at 16:54 +0200, Rafael J. Wysocki wrote:
> > Fewer jumps are easier to follow in general, so avoiding ones that can
> > be avoided is helpful.
> >
> > I'm not buying the argument about more code line changes needed if the
> > function name changes.  It's meaningless.
> >
> > And if you check the return value of acpi_get_table() for SRAT after
> > calling acpi_put_table(tbl), you will only need the out_free label, if
> > I'm not mistaken.
>
> I don't really understand this.

Sorry, I didn't have the original code in front of me when I was
writing my reply.

I was thinking about checking the return value of
acpi_table_parse_entries() after calling acpi_put_table(tbl).  Then,
if it returns an error, you only need to call hmat_free_structures().

Similarly, if acpi_get_table(ACPI_SIG_HMAT, 0, &tbl) returns an error,
you only need to call hmat_free_structures().

But I didn't remember the other jumps to out_put.

Still, since it is valid to pass NULL to acpi_put_table(), you can
jump to out_put if acpi_get_table(ACPI_SIG_HMAT, 0, &tbl) returns an
error too.
