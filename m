From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 2/2] ACPI/IORT: Remove iort_node_match()
Date: Thu, 15 Jun 2017 12:01:03 +0800
Message-ID: <e1ee59e9-d4e9-d820-1a32-c5ce958702b7@linaro.org>
References: <20170614163713.14574-1-lorenzo.pieralisi@arm.com>
 <20170614163713.14574-2-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170614163713.14574-2-lorenzo.pieralisi@arm.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>
List-Id: linux-acpi@vger.kernel.org

On 2017/6/15 0:37, Lorenzo Pieralisi wrote:
> Commit 316ca8804ea8 ("ACPI/IORT: Remove linker section for IORT entries
> probing") removed the linker section for IORT entries probing.
> 
> Since those IORT entries were the only iort_node_match() interface
> users, the iort_node_match() became obsolete and can then be removed.
> 
> Remove the ACPI IORT iort_node_match() interface from the kernel.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>

Nice catch,

Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
