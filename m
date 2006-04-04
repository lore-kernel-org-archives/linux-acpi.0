From: Adrian Bunk <bunk@stusta.de>
Subject: 2.6.17-rc1-mm1: why did acpi_ns_build_external_path() become global?
Date: Tue, 4 Apr 2006 18:29:55 +0200
Message-ID: <20060404162955.GN6529@stusta.de>
References: <20060404014504.564bf45a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750753AbWDDQab@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060404014504.564bf45a.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, len.brown@intel.com
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Apr 04, 2006 at 01:45:04AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.16-mm2:
> 
>  git-acpi.patch
>...
>  git trees.
>...

acpi_ns_build_external_path() became global but isn't used outside the 
file it's defined in.

Was this accidental or is a usage pending?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
