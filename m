From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: linux-next: Tree for October 24 (ACPI)
Date: Sun, 26 Oct 2008 11:59:33 +0100
Message-ID: <200810261159.34620.rjw@sisk.pl>
References: <20081024171932.1e8131d0.sfr@canb.auug.org.au> <20081025171606.f492a353.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20081025171606.f492a353.randy.dunlap@oracle.com>
Content-Disposition: inline
Sender: linux-next-owner@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, lenb@kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sunday, 26 of October 2008, Randy Dunlap wrote:
> On Fri, 24 Oct 2008 17:19:32 +1100 Stephen Rothwell wrote:
> 
> 
> linux-next-20081024/drivers/acpi/sleep/main.c:505: error: 'acpi_target_sleep_state' undeclared (first use in this function)
> linux-next-20081024/drivers/acpi/sleep/main.c:576: error: 'acpi_target_sleep_state' undeclared (first use in this function)
> make[4]: *** [drivers/acpi/sleep/main.o] Error 1

Yeah, there's a fix in the Len's tree:

http://git.kernel.org/?p=linux/kernel/git/lenb/linux-acpi-2.6.git;a=commit;h=92daa7b53b76984565dfdfda5d9c679884121fb2

but Linus hasn't pulled it yet.

Thanks,
Rafael
