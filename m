From: Al Stone <al.stone@linaro.org>
Subject: Re: [PATCH v4 1/5] ACPI: introduce CONFIG_ACPI_REDUCED_HARDWARE to
 enable this ACPI mode
Date: Mon, 06 Jan 2014 15:38:39 -0700
Message-ID: <52CB306F.1020201@linaro.org>
References: <1387239401-13918-1-git-send-email-al.stone@linaro.org>
 <1387239401-13918-2-git-send-email-al.stone@linaro.org>
 <20131227045848.GB21429@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131227045848.GB21429@srcf.ucam.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linaro-kernel@lists.linaro.org, linaro-acpi@lists.linaro.org, patches@linaro.org, linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

On 12/26/2013 09:58 PM, Matthew Garrett wrote:
> On Mon, Dec 16, 2013 at 05:16:37PM -0700, al.stone@linaro.org wrote:
>
>> +config ACPI_REDUCED_HARDWARE
>> +	bool "Hardware-reduced ACPI support"
>> +	depends on ARM || ARM64
>> +	help
>> +	This config adds support for Hardware-reduced ACPI.
>
> Well, that's not really true - most of the hardware-reduced ACPI support
> seems to be built even if this isn't turned on. Maybe
> ACPI_REDUCED_HARDWARE_ONLY ?
>

Aha.  Good point; semantically, it is unclear as is.  I'll clarify
and re-submit.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Linaro Enterprise Group
al.stone@linaro.org
-----------------------------------
