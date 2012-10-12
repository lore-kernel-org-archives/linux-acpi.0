From: Khalid Aziz <khalid@gonehiking.org>
Subject: Re: [PATCH v6 1/2] ACPI: Add early console framework for DBGP/DBG2.
Date: Fri, 12 Oct 2012 13:24:03 -0600
Message-ID: <1350069843.7065.65.camel@rhapsody>
References: <cover.1348652044.git.lv.zheng@intel.com>
	 <09ee0e9c79c57da2fc9d0af1c2daeaacdc0bb234.1349838218.git.lv.zheng@intel.com>
	 <20121010174406.GA13861@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20121010174406.GA13861@srcf.ucam.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Jason Wessel <jason.wessel@windriver.com>, Feng Tang <feng.tang@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 2012-10-10 at 18:44 +0100, Matthew Garrett wrote:
> On Wed, Oct 10, 2012 at 11:23:01AM +0800, Lv Zheng wrote:
> > Microsoft Debug Port Table (DBGP or DBG2) is used by the Windows SoC
> > platforms to describe their debugging facilities.
> > DBGP: http://msdn.microsoft.com/en-us/windows/hardware/hh134821
> > DBG2: http://msdn.microsoft.com/en-us/library/windows/hardware/hh673515
> 
> The license for these specifications only covers BIOS implementations, 
> not OS implementations. Has this had appropriate legal review?
> 

I agree with Matthew. There are potential legal issues with using
DBGP/DBGP2 tables in Linux. I had added support for SPCR and DBGP tables
many years ago (in early 2.6 kernel timeframe) before Microsoft added
this new license. I pulled the code out (in 2.6.14, I think) after
Microsoft added the new license to these tables. I agree with Matthew's
interpretation that the license is clear only about BIOS vendors being
allowed to use these tables. PCDP table in DIG64 spec was introduced to
get around the legal issues with using SPCR and DBGP in Linux.

License for DBGP/DBGP2 needs some legal review before this patch can go
into Linux.

--
Khalid
