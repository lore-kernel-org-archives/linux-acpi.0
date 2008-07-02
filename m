From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH -next] acpi utmisc: use WARN_ON() instead of warn_on_slowpath()
Date: Wed, 02 Jul 2008 20:50:04 +0200
Message-ID: <486BCDDC.1000709@firstfloor.org>
References: <20080701103339.b5acc1f3.randy.dunlap@oracle.com>	<20080701131714.5093fa49.akpm@linux-foundation.org>	<23433248.1214943818230.JavaMail.oracle@acsmt302.oracle.com>	<20080701133535.f92a673c.akpm@linux-foundation.org> <20080702112852.05f30950.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20080702112852.05f30950.randy.dunlap@oracle.com>
Sender: linux-next-owner@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-next@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> utmisc.c needs to include asm-generic/bug.h for warn()/WARN() functions,
> but it should use WARN_ON() instead of warn_on_slowpath() since
> arches can provide their own implementation of WARN_ON(), which does
> not have to use/provide/implement warn_on_slowpath() at all.
> Just use the front door (WARN_ON).
> 
> linux-next-20080702/drivers/acpi/utilities/utmisc.c:1027: error: implicit declaration of function 'warn_on_slowpath'

On what architecture did you see that?

It might be be better to just provide it on all architectures supported
by ACPI (x86, ia64). I suppose it was ia64?

-Andi
