From: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH -next] acpi/hmat: fix an uninitialized memory_target
Date: Mon, 8 Apr 2019 09:44:15 -0600
Message-ID: <20190408154415.GG32498@localhost.localdomain>
References: <20190407011222.38963-1-cai@lca.pw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190407011222.38963-1-cai@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
To: Qian Cai <cai@lca.pw>
Cc: gregkh@linuxfoundation.org, rjw@rjwysocki.net, lenb@kernel.org, keith.busch@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Apr 06, 2019 at 09:12:22PM -0400, Qian Cai wrote:
> The commit 665ac7e92757 ("acpi/hmat: Register processor domain to its
> memory") introduced an uninitialized "struct memory_target" that could
> cause an incorrect branching.

Thanks for the catch. We do have another patch submitted a few days that
fixes this, though:

  https://patchwork.kernel.org/patch/10887487/
