From: Qian Cai <cai@lca.pw>
Subject: Re: [PATCH -next] acpi/hmat: fix memory leaks in hmat_init()
Date: Tue, 09 Apr 2019 11:33:16 -0400
Message-ID: <1554823996.26196.48.camel@lca.pw>
References: <20190406181704.33574-1-cai@lca.pw>
         <CAJZ5v0jxUn_Hhm21FFBc2eSp49kCciCzR1_UGewHkpJiTy3LGw@mail.gmail.com>
         <1554816309.26196.46.camel@lca.pw>
         <CAJZ5v0g_oLdqv_sp8Un-44wO6vtQH6rVeUTKxSynO8VPPascxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0g_oLdqv_sp8Un-44wO6vtQH6rVeUTKxSynO8VPPascxA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Keith Busch <keith.busch@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2019-04-09 at 16:54 +0200, Rafael J. Wysocki wrote:
> Fewer jumps are easier to follow in general, so avoiding ones that can
> be avoided is helpful.
> 
> I'm not buying the argument about more code line changes needed if the
> function name changes.  It's meaningless.
> 
> And if you check the return value of acpi_get_table() for SRAT after
> calling acpi_put_table(tbl), you will only need the out_free label, if
> I'm not mistaken.

I don't really understand this.

status = acpi_get_table(ACPI_SIG_SRAT
acpi_put_table(tbl);
status = acpi_get_table(ACPI_SIG_HMAT

If acpi_get_table(ACPI_SIG_SRAT failed, there is no point calling
acpi_put_table(), so what is the point checking return value of acpi_get_table()
for SRAT after acpi_put_table() ?
