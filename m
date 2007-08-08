From: Tejun Heo <htejun@gmail.com>
Subject: Re: Disk spin down issue on shut down/suspend to disk
Date: Wed, 08 Aug 2007 11:56:45 +0900
Message-ID: <46B930ED.6040607@gmail.com>
References: <fa.bsWpbo79BZgHoaIGhEMfTEBxs54@ifi.uio.no> <1186514618.5622.9.camel@nx6310> <8db1092f0708071309h5cf6f68bo80b44d9a2fbeabeb@mail.gmail.com> <200708072233.52500.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <200708072233.52500.rjw@sisk.pl>
Sender: linux-ide-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Maciej Rutecki <maciej.rutecki@gmail.com>, Michael Sedkowski <sedmich@gmail.com>, trenn@suse.de, Robert Hancock <hancockr@shaw.ca>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Rafael J. Wysocki wrote:
> Well, on my box (nx6325) with the appended (experimental) patch applied
> on top of 2.6.23-rc1 with the patchset from
> http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.23-rc2/patches/ , the
> double spin down doesn't occur during hibernation and the system is shut down
> notceably faster.

Can you please explain what the patch does?  So, I take it that entering
S4 also spins down the disk.  Does the patch remove the ACPI spin down
or libata one?

-- 
tejun
