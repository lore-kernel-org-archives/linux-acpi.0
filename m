From: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH 15/25] coresight: etm3x: Rearrange cp14 access detection
Date: Thu, 28 Mar 2019 11:03:43 +0000
Message-ID: <c2e647a3-17ea-326f-df1a-7e73ff918994@arm.com>
References: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
 <1553107783-3340-16-git-send-email-suzuki.poulose@arm.com>
 <20190327220559.GB778@xps15>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190327220559.GB778@xps15>
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
To: mathieu.poirier@linaro.org
Cc: coresight@lists.linaro.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, robert.walker@arm.com, linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org
List-Id: linux-acpi@vger.kernel.org

On 03/27/2019 10:05 PM, Mathieu Poirier wrote:
> On Wed, Mar 20, 2019 at 06:49:32PM +0000, Suzuki K Poulose wrote:
>> As we are about to about refactor the platform specific handling,
> 
> s/about//
> 
>> move the DT property handling to generic helpers.
>>

Thanks for spotting. Will fix it.

Suzuki
