From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v3 1/9] ACPI: fix all errors reported by cleanpatch.pl
 in osl.c
Date: Wed, 25 Feb 2015 20:47:53 +0800
Message-ID: <54EDC479.4000603@linaro.org>
References: <1424824585-6405-1-git-send-email-al.stone@linaro.org> <1424824585-6405-2-git-send-email-al.stone@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <1424824585-6405-2-git-send-email-al.stone@linaro.org>
Sender: linux-ia64-owner@vger.kernel.org
To: al.stone@linaro.org, rjw@rjwysocki.net, lenb@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, robert.moore@intel.com, tony.luck@intel.com, fenghua.yu@intel.com
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org, linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org, linaro-kernel@lists.linaro.org, patches@linaro.org
List-Id: linux-acpi@vger.kernel.org

On 2015=E5=B9=B402=E6=9C=8825=E6=97=A5 08:36, al.stone@linaro.org wrote=
:
> From: Al Stone <al.stone@linaro.org>
>
> In preparation for later splitting out some of the arch-dependent cod=
e from
> osl.c, clean up the errors reported by checkpatch.pl.  They fell into=
 these
> classes:
>
>     -- remove the FSF address from the GPL notice
>     -- "foo * bar" should be "foo *bar" (and the ** variation of same=
)
>     -- a return is not a function, so parentheses are not required.
>
> Signed-off-by: Al Stone <al.stone@linaro.org>

Reviewd-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-ia64" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
