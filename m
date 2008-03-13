From: Andrea Arcangeli <andrea@qumranet.com>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.25-rc5
Date: Thu, 13 Mar 2008 13:50:16 +0100
Message-ID: <20080313125016.GZ7365@v2.random>
References: <200803130214.36861.lenb@kernel.org> <20080312234516.bb079cc5.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755801AbYCMMun@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080312234516.bb079cc5.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-acpi@vger.kernel.org

On Wed, Mar 12, 2008 at 11:45:16PM -0700, Andrew Morton wrote:
> http://userweb.kernel.org/~akpm/mmotm/broken-out/revert-acpi-thermal-fixup.patch
> 
>   Hopeully fix a regression which Andrea Arcangeli hit.  Although I'm not sure
>   that he has confirmed that this revert actually works?

Last time I tried it fixed my boot failure (I found it by bisecting).

Thanks.
