From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [RFC/RFT PATCH 0/2] disable_hest quirk on HP m400 with bad UEFI
 firmwware
Date: Thu, 28 Jun 2018 22:56:29 +0200
Message-ID: <CAKv+Gu8OkHZJL8FXhsfQP8JodWLTFg5kz4wVcDPVWTs-29buug@mail.gmail.com>
References: <20180628100656.10692-1-james.morse@arm.com>
 <CAKv+Gu9ZHAGzcfgHShM1qvZ3qf4gb1pD_XfoceJu9Qy+5_pEsg@mail.gmail.com>
 <ef039f0c-dea2-80d7-e6fa-481f3452a600@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <ef039f0c-dea2-80d7-e6fa-481f3452a600@infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Geoff Levand <geoff@infradead.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Riku Voipio <riku.voipio@linaro.org>, Mark Salter <msalter@redhat.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, James Morse <james.morse@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-acpi@vger.kernel.org

On 28 June 2018 at 18:15, Geoff Levand <geoff@infradead.org> wrote:
> Hi Ard,
>
> On 06/28/2018 03:25 AM, Ard Biesheuvel wrote:
>
>> Given how the upstream kernel is aimed at future development, I don't
>> think we should fix this in the upstream kernel at all. Distros are
>> free to do what they like, of course, and I'm sure RedHat already have
>> a fix for this in their downstream kernel.
>
> Debian expects the kernel to work correctly, and so won't add a fix.
> That means CONFIG_ACPI_APEI can't be enabled, and so users must either
> go without APEI or use a custom built kernel. See:
>
>   https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=900581
>

Hi Geoff,

I am aware of the context of this discussion, and I feel your pain,
given that you don't care about m400 in the first place.

So I guess we should take this up with the Debian folks directly. They
apparently do care about m400, and are reluctant to have to add
'hest_disable=1' to the kernel command line.

But that does not make it an upstream problem. The fact that this is
an EOL platform of which only a couple of hundred are in circulation,
combined with the fact that there is a trivial workaround available
(the command line option) makes it a non-issue in my opinion,
especially given the fact that not a single distro ships pristine
mainline kernels, and so they can carry the quirk themselves.

I
