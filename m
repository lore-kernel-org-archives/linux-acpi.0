From: Ralph Ronnquist <ralph-vtnOFD7OtW9sbIuE7sb01ikBLnlaf3ui@public.gmane.org>
Subject: Re: failed patch for 2.4.20
Date: Sun, 06 Apr 2003 10:26:38 +1000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m191xza-00B4VdC@studio.hemma>
References: <20030405155552.GA22362@Tonelli.sns.it>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----- =_aaaaaaaaaa0"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: Message from debdev@Tonelli.sns.it (A Mennucc1)
   of "Sat, 05 Apr 2003 17:55:52 +0200." <20030405155552.GA22362-C7jUcIT7jcOb5HrIuDsk0A@public.gmane.org>
Content-ID: <1415.1049588793.0-vtnOFD7OtW9sbIuE7sb01ikBLnlaf3ui@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: mennucc1-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

------- =_aaaaaaaaaa0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1415.1049588793.1-vtnOFD7OtW9sbIuE7sb01ikBLnlaf3ui@public.gmane.org>

At Sat, 5 Apr 2003 17:55:52 +0200, A Mennucc1 writes:
> 
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: failed patch for 2.4.20
> Reply-To: debdev-JzoyWj5SOTSb5HrIuDsk0A@public.gmane.org
> From: Andrea C G Mennucci <andrea-XQfoZfwGqr6d5S4pzSRqXw@public.gmane.org>
> 
> 
> hi
> 
> I tried to apply acpi-20021212-2.4.20.diff.gz
> on the kernel sources 2.4.20  that are distributed with Debian;
> but I got too many rejects, and indeed compilation fails
> 
> (whereas acpi-20020918-2.4.19 worked on Debian's 2.4.19)

Hi Andrea,

I've done the same and worked through the rejects by hand. It's not
too hard really as almost all are Makefile changes, and most concern
the same thing. FWIW I've attached my Makefiles.

Unfortunately the acpi patch not enough to get everything working,
which is something I have to thank Compaq for: Don't by Compaq!!

regards,

Ralph.


------- =_aaaaaaaaaa0
Content-Type: application/octet-stream; name="makefiles.tgz"
Content-ID: <1415.1049588793.2-vtnOFD7OtW9sbIuE7sb01ikBLnlaf3ui@public.gmane.org>
Content-Transfer-Encoding: base64

H4sIAF1yjz4AA+2afW+qSBTG/Xf5FJPUm8hutSi+JDfZZH1rr4kVo5i9N9nEIIx1tgjeGejLt7+H
Nwttqbm5Bnfj+ZkoLQ8zZ4Z5zgHU4uyBcnFlmDt2dWvc0zWzaem4KHVFaTebJQXotKNPpaVEn4rS
aHc6JdihdlodVW03QA/vjRJRjhzHu/jCMzghJW7Yu80HOsHNIsIpmgvpgiSnnaxdTrwNJWPm+E+k
25+OCHM8ynecwjsoJUlb6t3ZzVAnn/8kwZqpuZJEn3Yu90L9sn897t7MJSn1RyCtDpbj0WTxlVRH
5Up/MRuMZvIVc0zbt6gksbVF16SvTa5HN8vwyMGwt7iRSLpN8kfQzMvepbbQpwtdoo7F1pI0/KrP
uilpuZI6Vk6CrLqrfwUhSfTLe/G8FTWX7LhrUiFcHowHNNVnkvBKKknBlIVz03Ndr6qzLSW6sYLp
mxpcMOcOBGxNv5MKjDQ1pJ6m6fLlswyjynYQASF7QStBNCvbMO9tJjzoLh7evtO+yymZ+yvxLDy6
JZXRywmSc3oeTfThbDobwvvHAbjCht59j9nBQAkR/spiPFLCbouJneGZG8oJfaCOJwh9oqYPPZON
wa1HAyJzjC0FlUnJDmYD9vwjkddwKlyfw3zHIw57ZB6j4lVo4WmERUkNcwO988tyJQlJhm3YkK+i
j5orv5mpni+I4VhkQB8YxDOIMl3e2VnMP5ib10BgKz+ao0Cebarbl19khpmj6nV1OB/f5Kgxw4NZ
fM6TLnRdm8hJv57nOjnK4b7rVKQ0L4Tr7kTeq9ZGXqPT/uhFtjPZksO6DzwDmzZz7uNNxr/HWyvm
WHltaX/DIkzach8pzxPOtP5wPtdmcmokaZe+d5D+ZTi77Y6jOYVExreGnSOdf5vrw9t4TiMv5Sgn
i9uunETg+Fsjr3Nt/mXU68adu2LDVsYyTpHx0owTHixqXZuGKXDmB47fQgKGhRuJP8PuYCtMVWDp
38qV8UAmVU6qLin/ld37y/nfStd/i678uzvKj3whcKD+K02lndT/OlwBgL6ldrD+F8Kb+m/Ydk79
j8sBNT2XB7n6InilrwfKFcf1QEH2JR7yciB6a5Z0SYoOhcoC7QuPfKqZl59qLuT3R2ZbJhQW8nvN
lOWkoW2kTzoO/3+g+IPiQ+tdnPosnI6s//cF/qgZ4JD/1Y6693+7VQ/831Hb6P8i+CX/S4fdLx3H
+9K7zj940f+h60899f8JMv6PruqP/hjgp/xfbwf+r9db6P8iQP+fN1n/x7fzBV//p/3f6oT+bzbx
+r8Q0P/nTcb/yVO8U/pfVUL/K3X0fxGg/8+bjP/3D++PmwB+yv9K+PwPEgD6vwjQ/+dNxv/RV3Yn
vf9vqo3w/h/rfzGg/8+bjP/3X8yfrv436+Hz/3a9if4vAvT/eZPxf/RznJPWf7UV3v8rLfz+rxDQ
/+dNxv/73+Gdrv43OuH9f7uhov+LAP2PIAiCIAiCIAiCIAiCIAiCIAiCIAiCIAjy/+YHwwBMQQBQ
AAA=

------- =_aaaaaaaaaa0--


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
