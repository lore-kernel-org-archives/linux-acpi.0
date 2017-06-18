From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: [PATCH 0/7] fujitsu-laptop: ACPI-related cleanups
Date: Sun, 18 Jun 2017 20:05:15 +0930
Message-ID: <20170618103515.GH26810@marvin.atrad.com.au>
References: <20170616044058.30443-1-kernel@kempniu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170616044058.30443-1-kernel@kempniu.pl>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Micha?? K??pie?? <kernel@kempniu.pl>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Michel

On Fri, Jun 16, 2017 at 06:40:51AM +0200, Micha?? K??pie?? wrote:
> In preparation for splitting fujitsu-laptop into two separate modules, I
> prepared two more cleanup series to minimize the amount of code being
> moved around.  This first series contains all patches that touch ACPI in
> some way, which is why I am CCing linux-acpi as per Rafael's previous
> advice.
> 
> This patch series was based on platform-driver-x86/for-next and tested
> on a Lifebook S7020.

As far as I can tell this series looks good.  It is, as you said, another
step towards the splitting of this driver into two separate modules.  I have
a few brief comments.

Patch 1: 
 - The argument for this change assumes that the execution methodology of
   the acpi_os_execute() remains as is, since this is what guarantees the
   absence of concurrency concerns.  If it is fair to assume that we don't
   have to worry about such things which may never happen then there's no
   problem with this patch.

Patch 2:
 - No problem.

Patch 3: 
 - No problem.

Patch 4: 
 - Presumedly the change in device path doesn't count as an API change. 
   Given that, I have no objection since the argument put forward makes
   sense.

Patch 5:
 - I am not overly familiar with the power management infrastructure within 
   the ACPI subsystem, but the presented argument seems sensible to me. 
   This patch is therefore fine if the given assumptions hold.

Patch 6:
 - This seems fair.

Patch 7: 
 - The motivations which lead to the creation of the debug Kconfig option
   are now moot.  The elimination of this and the custom logging code is
   therefore entirely justified.

To summarise, I see no major issues with this patch set so long as the minor
details noted above are of no consequence.  Applying this will assist with
the end-goal of splitting the driver into two modules since it will minimise
the changes needed at the time the split is carried out.

Reviewed-by: Jonathan Woithe <jwoithe@just42.net>

Regards
  jonathan
