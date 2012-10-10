From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH v6 1/2] ACPI: Add early console framework for DBGP/DBG2.
Date: Wed, 10 Oct 2012 18:44:06 +0100
Message-ID: <20121010174406.GA13861@srcf.ucam.org>
References: <cover.1348652044.git.lv.zheng@intel.com>
 <09ee0e9c79c57da2fc9d0af1c2daeaacdc0bb234.1349838218.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <09ee0e9c79c57da2fc9d0af1c2daeaacdc0bb234.1349838218.git.lv.zheng@intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Jason Wessel <jason.wessel@windriver.com>, Feng Tang <feng.tang@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Oct 10, 2012 at 11:23:01AM +0800, Lv Zheng wrote:
> Microsoft Debug Port Table (DBGP or DBG2) is used by the Windows SoC
> platforms to describe their debugging facilities.
> DBGP: http://msdn.microsoft.com/en-us/windows/hardware/hh134821
> DBG2: http://msdn.microsoft.com/en-us/library/windows/hardware/hh673515

The license for these specifications only covers BIOS implementations, 
not OS implementations. Has this had appropriate legal review?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
