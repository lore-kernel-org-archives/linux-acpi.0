From: Joe Perches <joe@perches.com>
Subject: Re: Extended H/W error log driver
Date: Fri, 11 Oct 2013 00:00:39 -0700
Message-ID: <1381474839.27498.11.camel@joe-AO722>
References: <1381473166-29303-1-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1381473166-29303-1-git-send-email-gong.chen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, bp@alien8.de, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 2013-10-11 at 02:32 -0400, Chen, Gong wrote:
> This patch series adds an enhanced MCA event logging driver provided by Intel.
[]
> dmesg output:
> 
> [56005.785917] {3}Hardware error detected on CPU0
> [56005.785959] {3}event severity: corrected
> [56005.785975] {3}sub_event[0], severity: corrected
> [56005.785977] {3}section_type: memory error
> [56005.785981] {3}physical_address: 0x0000000851fe0000
> [56005.786027] {3}DIMM location: Memriser1 CHANNEL A DIMM 0
> [56005.786154] {4}Hardware error detected on CPU0
> [56005.786159] {4}event severity: corrected
> [56005.786162] {4}sub_event[0], severity: corrected
> [56005.786166] {4}section_type: memory error
[]
> So welcome to add comments for what is needed or not.

Perhaps there can be a better standardized prefix other than {seq}
like KBUILD_MODNAME or some other useful identifier like subsystem
name.
