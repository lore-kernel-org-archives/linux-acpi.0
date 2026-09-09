Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545F45650ED
	for <linux-acpi@vger.kernel.org>; Wed,  9 Sep 2026 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788968178; cv=none; b=ZRCKA8Qd9Mq11XDQeXsxNZ/q5atPTrvKHdE5bhSTkx0BV9MedfUr1Knvclp/6Is58TM4BNUqcoZo/3EVPsz3DARCtkN80zu1oHr9+XvlFKyOGoLEOdCFSoLg+/gv5hIYVzyh1K7G+N7JpHXprJROhD1V6m+faJWstqKf6njD10c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788968178; c=relaxed/simple;
	bh=jDMUsnnYqogjhXxCOn9mNMOrmCNKYoJwQpQTW4uHJzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mvwUPGrRA+F8fxzAZeaicjfppL6CDoqqSb5OiKbKOk2sLzgsLRzQI+HpOCulpLMAfTPAudEMdy8W0KpwuCHCxBte0FQieVSW/Q3ryzefSl0uFaUq29/pQIFXJ8H5DYdiZc6YuRQKerLl0bpYLgmBVRkdvlgUSem57przqPBHayU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zx/HMP63; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zx/HMP63"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6371F00A3A
	for <linux-acpi@vger.kernel.org>; Wed,  9 Sep 2026 15:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788968177;
	bh=XmcpQyokakiNfBd8epSab7pog++2XEktXMmOmQUH1xs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Zx/HMP63ACiRHHGW8SSiPE5bLKcU7H81LIJa2WPSMJhwFUenUV+qRTllpK2bA+xye
	 W5yw0hWLx4MfSuG8CDUpvKwh8XElEs+lMU/qTNUxXutmzYHoIDNLp7hrfG9sWGDY9G
	 bFFJhRxrHGb8HXCC6+Hzg9Ur5e95ZWxDyKPu5DHy8IJm2JYPaclaj2JNXlgC927kar
	 UtAz5AvtHRVtSEt32m4EJGcwC7ahClHpf1sBanqomED3TU987rvsYHqulsvf+dkZFu
	 zhGiW3cZxTvQANKWhG/RIAxDpnuS6ynGmo/jE9vl56rD1bFcBPyCUaAyAvN9ObkVWn
	 2q/FId3u+Bd6Q==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f1e428so811808e87.1
        for <linux-acpi@vger.kernel.org>; Wed, 09 Sep 2026 08:36:17 -0700 (PDT)
X-Gm-Message-State: AFuF++m+bY2HsDwidVicfsdtgHRCU6q+S8XAK/op7wStaL4XCCegXcbb
	AbRfDXQGaGmDSRDOpJMcfrCq0YmyMAP3z+geT8/Y76E+yBvtW1CLxvVxgQcko59gp1Ve9ST2GBi
	BfQSGvDWEg0kvZHbPoyez6N8DHHaGe7k=
X-Received: by 2002:a05:6512:668e:10b0:5b6:10bc:b864 with SMTP id
 2adb3069b0e04-5b75c918261mr1494885e87.18.1788968175592; Wed, 09 Sep 2026
 08:36:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPAw8HGxmd2V5GgjL191f3pwOnbuGp4cfDaxCWiR57EquLOecw@mail.gmail.com>
In-Reply-To: <CAPAw8HGxmd2V5GgjL191f3pwOnbuGp4cfDaxCWiR57EquLOecw@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 9 Sep 2026 17:35:06 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j1w__nuVEvrYsbUViihJOSbZxPAD2P442FG+DczaDjeg@mail.gmail.com>
X-Gm-Features: AcwNN1WGuNo66E-I8ww7xj82Tjd0isS2O9w0P0P-WyGDZrV2I0TjaeQO_9kq6co
Message-ID: <CAJZ5v0j1w__nuVEvrYsbUViihJOSbZxPAD2P442FG+DczaDjeg@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Parser: do not set the AML pointer to a NULL AmlLastWhile
To: Vlatko Kosturjak <vlatko.kosturjak@gmail.com>
Cc: linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Saket Dumbre <saket.dumbre@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 6:27=E2=80=AFAM Vlatko Kosturjak
<vlatko.kosturjak@gmail.com> wrote:
>
> AcpiPsNextParseState() can set ParserState->Aml to NULL, after which the =
parse
> loop dereferences it in AcpiPsPeekOpcode(). A malformed ACPI table suppli=
ed by
> firmware therefore panics the kernel in PID 1 during acpi_init(), before
> userspace exists - the machine does not boot.
>
> This is the largest of a set of related findings: it accounts for 110 of =
189
> malformed SSDTs that leave a stock x86_64_defconfig kernel unbootable
> (tested on pristine Linux 7.2.2 - tag: v7.2.2). The smallest trigger
> is a 46-byte table containing no While, Break or Continue at all.
>
> WalkState->AmlLastWhile is only ever assigned in AcpiDsExecEndOp() while
> handling a While loop, so outside a loop it is still NULL from the zeroed=
 walk
> state. AcpiPsNextParseState() assigns it to ParserState->Aml for AE_CTRL_=
BREAK,
> AE_CTRL_CONTINUE and AE_CTRL_PENDING.
>
> The first two are guarded at their source; AE_CTRL_PENDING is not, and it=
 is not
> a loop-only status. AcpiExNameSegment() returns it for any name segment t=
hat
> starts with a digit or a non-alpha character - entirely controlled by the=
 AML
> being parsed, with no loop involved. AcpiPsPeekOpcode()'s bounds check do=
es not
> help, because NULL < AmlEnd passes.
>
> In Linux this is reached from AcpiTbLoadNamespace() during acpi_init(), s=
o a
> table supplied by firmware faults in PID 1 inside do_one_initcall() and
> panics the kernel before userspace exists:
>
>   BUG: kernel NULL pointer dereference at 0000000000000000
>   RIP: 0010:acpi_ps_peek_opcode+0x16/0x40
>    acpi_ps_get_next_arg / acpi_ps_parse_loop / acpi_ps_parse_aml
>    acpi_ns_load_table / acpi_tb_load_namespace / acpi_init
>   Kernel panic - not syncing: Attempted to kill init!
>
> Refuse to take the branch when AmlLastWhile is NULL and fail the parse wi=
th
> AE_AML_NO_WHILE, whose existing text is "Break or Continue without a Whil=
e".
> Also NULL-check WalkState->ControlState on the two paths that dereference=
 it;
> the AE_CTRL_FALSE comment already says "a predicate (if any)".
>
> One detail worth keeping if you rework the patch: it also sets
> ParserState->Aml =3D ParserState->AmlEnd on the error paths. That is requ=
ired, not
> cosmetic. During a table load AcpiPsParseLoop() deliberately converts AML
> exceptions back to AE_OK ("keep trying to load the table"), so an error r=
eturn
> that does not advance the AML pointer re-parses the same position forever=
. An
> earlier version of this patch omitted it and turned one table's panic int=
o a
> hang.
>
> Why this matters beyond "bad firmware breaks your machine": under confide=
ntial
> computing the host is untrusted by design and supplies the guest's ACPI t=
ables.
> Documentation/security/snp-tdx-threat-model.rst lists "Malformed runtime =
input"
> from a misbehaving host in its guest threat matrix. That is the model in =
which
> these are security bugs rather than robustness bugs.
>
> Reproducer, evidence and step-by-step instructions can be found at the
> issue reported here:
> https://github.com/open-acpica/acpica/issues/1226
>
> Sending this to the public list rather than security@kernel.org: the atta=
cker
> must already control the platform firmware, no control over the faulting
> pointer was demonstrated, and the fix is small with nothing to coordinate=
.
> Say so explicitly if you would rather it had gone elsewhere.

Yes, this needs to go to the upstream ACPICA project on GitHub as a
pull request as per
Documentation/driver-api/acpi/linuxized-acpica.rst.

> Signed-off-by: Vlatko Kosturjak <vlatko.kosturjak@gmail.com>
> ---
> diff --git a/source/components/parser/psparse.c
> b/source/components/parser/psparse.c
> index 1aacc0c..7fb28dc 100644
> --- a/source/components/parser/psparse.c
> +++ b/source/components/parser/psparse.c
> @@ -338,6 +338,15 @@ AcpiPsNextParseState (
>
>      case AE_CTRL_BREAK:
>
> +        if (!WalkState->AmlLastWhile || !WalkState->ControlState)
> +        {
> +            ACPI_ERROR ((AE_INFO,
> +                "Break without a valid enclosing While"));
> +            ParserState->Aml =3D ParserState->AmlEnd;
> +            Status =3D AE_AML_NO_WHILE;
> +            break;
> +        }
> +
>          ParserState->Aml =3D WalkState->AmlLastWhile;
>          WalkState->ControlState->Common.Value =3D FALSE;
>          Status =3D AE_CTRL_BREAK;
> @@ -345,12 +354,30 @@ AcpiPsNextParseState (
>
>      case AE_CTRL_CONTINUE:
>
> +        if (!WalkState->AmlLastWhile)
> +        {
> +            ACPI_ERROR ((AE_INFO,
> +                "Continue without a valid enclosing While"));
> +            ParserState->Aml =3D ParserState->AmlEnd;
> +            Status =3D AE_AML_NO_WHILE;
> +            break;
> +        }
> +
>          ParserState->Aml =3D WalkState->AmlLastWhile;
>          Status =3D AE_CTRL_CONTINUE;
>          break;
>
>      case AE_CTRL_PENDING:
>
> +        if (!WalkState->AmlLastWhile)
> +        {
> +            ACPI_ERROR ((AE_INFO,
> +                "Pending control state without a valid enclosing While")=
);
> +            ParserState->Aml =3D ParserState->AmlEnd;
> +            Status =3D AE_AML_NO_WHILE;
> +            break;
> +        }
> +
>          ParserState->Aml =3D WalkState->AmlLastWhile;
>          break;
>
> @@ -391,7 +418,10 @@ AcpiPsNextParseState (
>
>          /* In the case of a BREAK, just force a predicate (if any) to FA=
LSE */
>
> -        WalkState->ControlState->Common.Value =3D FALSE;
> +        if (WalkState->ControlState)
> +        {
> +            WalkState->ControlState->Common.Value =3D FALSE;
> +        }
>          Status =3D AE_CTRL_END;
>          break;
