From: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 05/12] acpi: sleep-while-atomic during S3 resume from
 ram
Date: Thu, 24 Feb 2005 23:38:15 -0800
Message-ID: <20050224233815.3c9a4908.akpm@osdl.org>
References: <200502230953.j1N9rFj1020702@shell0.pdx.osdl.net>
	<200502250832.46209.linux-kernel@borntraeger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <200502250832.46209.linux-kernel@borntraeger.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Borntraeger <linux-kernel@borntraeger.net>
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

Christian Borntraeger <linux-kernel@borntraeger.net> wrote:
>
> akpm@osdl.org wrote:
> > From: Christian Borntraeger <linux-kernel@borntraeger.net>
> >
> > During the wakeup from suspend-to-ram I get several warnings.
> >
> > Signed-off-by: Christian Borntraeger <linux-kernel@borntraeger.net>
> > Signed-off-by: Andrew Morton <akpm@osdl.org>
> 
> Andrew,
> 
> Len told me that he is going to solve the issue in a different and better 
> way.

OK, well I'll retain the patch until the problem is fixed anyway - it's my
lame-o bug tracking system.
