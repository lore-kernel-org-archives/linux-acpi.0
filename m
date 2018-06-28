From: Geoff Levand <geoff@infradead.org>
Subject: Re: [RFC/RFT PATCH 0/2] disable_hest quirk on HP m400 with bad UEFI
 firmwware
Date: Thu, 28 Jun 2018 09:15:28 -0700
Message-ID: <ef039f0c-dea2-80d7-e6fa-481f3452a600@infradead.org>
References: <20180628100656.10692-1-james.morse@arm.com>
 <CAKv+Gu9ZHAGzcfgHShM1qvZ3qf4gb1pD_XfoceJu9Qy+5_pEsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAKv+Gu9ZHAGzcfgHShM1qvZ3qf4gb1pD_XfoceJu9Qy+5_pEsg@mail.gmail.com>
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
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, James Morse <james.morse@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Riku Voipio <riku.voipio@linaro.org>, Mark Salter <msalter@redhat.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-acpi@vger.kernel.org

Hi Ard,

On 06/28/2018 03:25 AM, Ard Biesheuvel wrote:

> Given how the upstream kernel is aimed at future development, I don't
> think we should fix this in the upstream kernel at all. Distros are
> free to do what they like, of course, and I'm sure RedHat already have
> a fix for this in their downstream kernel. 

Debian expects the kernel to work correctly, and so won't add a fix.
That means CONFIG_ACPI_APEI can't be enabled, and so users must either
go without APEI or use a custom built kernel. See:

  https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=900581

-Geoff
