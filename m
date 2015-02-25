From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [Linaro-acpi] [PATCH v3 3/9] ACPI: clean up checkpatch warnings
 for various bits of syntax
Date: Wed, 25 Feb 2015 20:59:53 +0800
Message-ID: <54EDC749.8080200@linaro.org>
References: <1424824585-6405-1-git-send-email-al.stone@linaro.org> <1424824585-6405-4-git-send-email-al.stone@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <1424824585-6405-4-git-send-email-al.stone@linaro.org>
Sender: linux-ia64-owner@vger.kernel.org
To: al.stone@linaro.org, rjw@rjwysocki.net, lenb@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, robert.moore@intel.com, tony.luck@intel.com, fenghua.yu@intel.com
Cc: linaro-kernel@lists.linaro.org, linux-ia64@vger.kernel.org, linaro-acpi@lists.linaro.org, patches@linaro.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devel@acpica.org
List-Id: linux-acpi@vger.kernel.org

On 2015=E5=B9=B402=E6=9C=8825=E6=97=A5 08:36, al.stone@linaro.org wrote=
:
> From: Al Stone<al.stone@linaro.org>
>
> In preparation for later splitting out some of the arch-dependent cod=
e from
> osl.c, clean up a bunch of warnings for odd bits of syntax:
>
>     -- remove CVS keyword markers
>     -- remove a space from between a function name and an opening par=
enthesis
>     -- clean up all but one line > 80 characters (one just looks sill=
y if you
>        make it less than 80)
>     -- add blank lines after declarations in functions
>     -- remove extraneous braces ({})
>
> Signed-off-by: Al Stone<al.stone@linaro.org>

Reviewd-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-ia64" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
