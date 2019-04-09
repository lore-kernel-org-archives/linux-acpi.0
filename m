From: Qian Cai <cai@lca.pw>
Subject: Re: [PATCH -next] acpi/hmat: fix memory leaks in hmat_init()
Date: Tue, 09 Apr 2019 09:25:09 -0400
Message-ID: <1554816309.26196.46.camel@lca.pw>
References: <20190406181704.33574-1-cai@lca.pw>
         <CAJZ5v0jxUn_Hhm21FFBc2eSp49kCciCzR1_UGewHkpJiTy3LGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0jxUn_Hhm21FFBc2eSp49kCciCzR1_UGewHkpJiTy3LGw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Keith Busch <keith.busch@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2019-04-09 at 10:25 +0200, Rafael J. Wysocki wrote:
> On Sat, Apr 6, 2019 at 8:18 PM Qian Cai <cai@lca.pw> wrote:
> > 
> > The commit 665ac7e92757 ("acpi/hmat: Register processor domain to its
> > memory") introduced some memory leaks below due to it fails to release
> > the heap memory in an error path, and then the stack __initdata memory
> > which reference them get freed during boot renders those heap memory as
> > leaks.
> > 
> > unreferenced object 0xc8ff8008349e9400 (size 128):
> >   comm "swapper/0", pid 1, jiffies 4294709236 (age 48121.476s)
> >   hex dump (first 32 bytes):
> >     00 d0 9e 34 08 80 ff 84 d8 00 43 11 00 10 ff ff  ...4......C.....
> >     00 00 00 00 ff ff ff ff 00 00 00 00 00 00 00 00  ................
> >   backtrace:
> >     [<00000000869d4503>] __kmalloc+0x568/0x600
> >     [<0000000070fd6afb>] alloc_memory_target+0x50/0xd8
> >     [<00000000efa2081e>] srat_parse_mem_affinity+0x58/0x5c
> >     [<000000008bfaef74>] acpi_parse_entries_array+0x1c8/0x2c0
> >     [<0000000022804877>] acpi_table_parse_entries_array+0x11c/0x138
> >     [<00000000ffe9cd34>] acpi_table_parse_entries+0x7c/0xac
> >     [<00000000a7023afd>] hmat_init+0x90/0x174
> >     [<00000000694a86c1>] do_one_initcall+0x2d8/0x5f8
> >     [<0000000024889da9>] do_initcall_level+0x37c/0x3fc
> >     [<000000009be02908>] do_basic_setup+0x38/0x50
> >     [<0000000037b3ac0a>] kernel_init_freeable+0x194/0x258
> >     [<00000000f5741184>] kernel_init+0x18/0x334
> >     [<000000007b30f423>] ret_from_fork+0x10/0x18
> >     [<000000006c7147a8>] 0xffffffffffffffff
> > 
> > Signed-off-by: Qian Cai <cai@lca.pw>
> 
> Well, the catch is good, but the additional label is sort of excessive IMO.
> 
> > ---
> >  drivers/acpi/hmat/hmat.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
> > index b7824a0309f7..c9b8abcf012c 100644
> > --- a/drivers/acpi/hmat/hmat.c
> > +++ b/drivers/acpi/hmat/hmat.c
> > @@ -637,7 +637,7 @@ static __init int hmat_init(void)
> > 
> >         status = acpi_get_table(ACPI_SIG_HMAT, 0, &tbl);
> >         if (ACPI_FAILURE(status))
> 
> I would just add a hmat_free_structures() call here or rework the
> _put_table() logic which is not really straightforward.

I am not sure how adding a hmat_free_structures() call there would be better. If
the name has bee changed to something else in the future, it ends up needing to
change 2 places. It also not save the adding line-count either. I don't see how
to rework the acpi_put_table() logic to be better than adding a label here
either.

> 
> > -               return 0;
> > +               goto out_free;
> > 
> >         hmat_revision = tbl->revision;
> >         switch (hmat_revision) {
> > @@ -659,8 +659,9 @@ static __init int hmat_init(void)
> >         }
> >         hmat_register_targets();
> >  out_put:
> > -       hmat_free_structures();
> >         acpi_put_table(tbl);
> > +out_free:
> > +       hmat_free_structures();
> >         return 0;
> >  }
> >  subsys_initcall(hmat_init);
> > --
