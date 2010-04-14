From: Tero Roponen <tero.roponen@gmail.com>
Subject: Re: [acpi:battery?] kernel oops on boot
Date: Wed, 14 Apr 2010 16:50:04 +0300 (EEST)
Message-ID: <alpine.LFD.2.00.1004141641010.3640@terrop>
References: <20100414095750.GA3304@swordfish.minsk.epam.com> <20100414131324.GA6598@nb-core2.darkstar.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100414131324.GA6598@nb-core2.darkstar.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, astarikovskiy@suse.de, len.brown@intel.com
List-Id: linux-acpi@vger.kernel.org


On Wed, 14 Apr 2010, Luca Tettamanti wrote:

> Hello,
> I'm seeing a similar bug on my notebook (Asus F3Sa) with current git.
> -rc4 does not work, while -rc3 does work.
> 
> The error (at least in my case) is a division by zero in
> acpi_ex_insert_into_field.

I have a similar problem with Asus M50Vm. git-bisect found
the following commit and reverting it does indeed fix the
problem.

commit dadf28a10c3eb29421837a2e413ab869ebd9e168
Author: Alexey Starikovskiy <astarikovskiy@suse.de>
Date:   Wed Mar 17 13:14:13 2010 -0400

    ACPI: EC: Allow multibyte access to EC
    
    http://bugzilla.kernel.org/show_bug.cgi?id=14667
    
    Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
    Signed-off-by: Len Brown <len.brown@intel.com>

-- 
Tero Roponen
