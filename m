From: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [Lhns-devel] [PATCH][1/4] Add unregister_node() to
	drivers/base/node.c
Date: Thu, 23 Sep 2004 09:43:16 -0700
Sender: linux-ia64-owner@vger.kernel.org
Message-ID: <1095957796.21153.94.camel@localhost>
References: <20040920092520.A14208@unix-os.sc.intel.com>
	 <20040920094719.H14208@unix-os.sc.intel.com>
	 <20040924012301.000007c6.tokunaga.keiich@jp.fujitsu.com>
	 <20040924013123.000067cd.tokunaga.keiich@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <20040924013123.000067cd.tokunaga.keiich@jp.fujitsu.com>
To: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Cc: anil.s.keshavamurthy@intel.com, len.brown@intel.com, acpi-devel@lists.sourceforge.net, lhns-devel@lists.sourceforge.net, linux-ia64@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2004-09-23 at 09:31, Keiichiro Tokunaga wrote:
> -int __init register_node(struct node *node, int num, struct node *parent)
> +int register_node(struct node *node, int num, struct node *parent)

__devinit, please.

-- Dave

