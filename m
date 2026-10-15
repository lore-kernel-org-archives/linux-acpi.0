Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A724BFE9E
	for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2026 16:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792080390; cv=none; b=BjD4KIFOsRc+8d3oNmg/ZXBaxSYOowgDPgHC580AVyhP92zwyXqZSpSEatzQ3mi5XJR6W6BFyrWDF0ueeyiPJ155/PvSBQMSgLhL4pp/y+uQg7D1l5tlOtQcB4r+SbMvrNUA9uOw5D6AZQrVD2EfWQtQ/hEujGPzM8esz56wE6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792080390; c=relaxed/simple;
	bh=JRy8WuV4exW7p4qIs/BOc/PGDmmlLPaMWFRApWxRLWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jnkXeCMiaZyIBXYOJ2E5TrGvREwiiZCX92ngCo6ZWTrf3rn+zQtd1JDQO8NwdTTTS8ebp2aZzCmS5SKYPUphe1s4EikaQ0EQNWz75mRyw1ynvXmLyQF/5+X1+7Eo08iWE420VfCpz0Zkcp5RtgEnS3022+mEQrnxbdGUpMJwciQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RL/FSkDx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RL/FSkDx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1DD1F000C4
	for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2026 16:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792080380;
	bh=hI8KOglwVfLjpgYGNPmiWMcfPdIInUXk4KoNDHDeaws=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=RL/FSkDxyTHM/crL00t1O2DIbgrWNf9GW/nzewnXjTsU5EoawiSyzXJZR6/GJ3nKd
	 RiFGd4Fa1MAcz2k17wcsEvfCo2VsPIldf/iNJglWLMuPiyx9iPiIElA9VYvSirGtb8
	 eatsM3L5b/yyFvnG0D5OqGdy+FQ3tHk8m/6i/ee8RC63hJGcPx2GgpFc4fUUySimOp
	 zzx7CYi/QmyrHat3fO/9M/mvjajIk0BKtzExx82870slGwzTc+e7CJe9u3J435KVhs
	 kpK/9CUl5oiqHNSi3Qbh6EuCsNqhEYA10qODbLmAurpLyRkRMGBEnYKA8bN3OhaEw9
	 ezOXGYtSalw2Q==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5bced78b3dfso3772390e87.1
        for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2026 09:06:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByevfz4VM8nt4MY1rLDNrEygwRds1tMOZyyn09M3V4ZnKG5GGG5mZdzudB9aAHrDM5FQXamh9Xs8692@vger.kernel.org
X-Gm-Message-State: AFq9FYLm+szK4+82w1/3EXOv7T752n8Aa6PMX3GAyMkTgmhFmwcOK3av
	WUb1e8piINOQ+dFGz45a1D4DZUZ2CSJIOGTFPBgnP0wxYvJZOF00e5ev9MDgXo1uzBcNVrxlfuz
	sILAs2cFIq56kh0pzwvwJCWnMpTxsJZg=
X-Received: by 2002:a05:6512:12d0:b0:5bc:a9f9:b641 with SMTP id
 2adb3069b0e04-5bcde8d8464mr6434245e87.67.1792080378235; Thu, 15 Oct 2026
 09:06:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOx7e9+Vv8Pdyks=AbE5XG0ZyDgtKToKyBLTnt+H5RPn6VymVg@mail.gmail.com>
In-Reply-To: <CAOx7e9+Vv8Pdyks=AbE5XG0ZyDgtKToKyBLTnt+H5RPn6VymVg@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 15 Oct 2026 18:04:08 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jtuTdGckoMQMauPDrn1KZ9_-EyLx5LjD1Ndqj50pC7-g@mail.gmail.com>
X-Gm-Features: AclHuK_vMeKHThNLYW_RgnbUq11vQH6_X7jpU9aX6o1NklQD-30YX5Igk_rVtcs
Message-ID: <CAJZ5v0jtuTdGckoMQMauPDrn1KZ9_-EyLx5LjD1Ndqj50pC7-g@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Fix parse tree memory leak on AML execution error unwind
To: Iurii Trukhin <yuri@trukhin.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Erik Kaneda <erik.kaneda@intel.com>, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, 
	Pawel Chmielewski <pawel.chmielewski@intel.com>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 3:28=E2=80=AFAM Iurii Trukhin <yuri@trukhin.com> wr=
ote:
>
> acpi_ps_complete_this_op() decides whether to defer deletion of an
> AML_CLASS_ARGUMENT parse object to its enclosing parent by checking
> walk_state->op_info->class instead of the opcode class of the op being
> completed.
>
> When acpi_ps_complete_op() or acpi_ps_complete_final_op() unwinds open
> parser scopes on AE_CTRL_TERMINATE or an execution error (such as
> AE_NOT_FOUND when resolving a missing symbol inside a control method),
> it pops each enclosing parent op and passes it to
> acpi_ps_complete_this_op() while walk_state->op_info still points to the
> last child op that failed. If that failing child op was of class
> AML_CLASS_ARGUMENT (for example, AML_INT_NAMEPATH_OP when
> acpi_ps_get_arguments() fails to resolve a method call or predicate
> operand), acpi_ps_complete_this_op() sees AML_CLASS_ARGUMENT for every
> popped parent op and returns AE_OK early without deleting any of the
> enclosing parent subtrees.
>
> For nested control methods invoked via acpi_ds_call_control_method(),
> the walk state is initialized with root_op =3D NULL, so top-level ops in
> the called method (such as AML_IF_OP) have op->common.parent =3D=3D NULL
> and are never attached to a root scope op. Skipping
> acpi_ps_delete_parse_tree() during error unwind leaks the entire parse
> subtree (both Acpi-ParseExt and Acpi-Parse objects, the latter merged
> by SLUB into the 80-byte Acpi-State kmem_cache on 64-bit kernels) on
> every failed GPE or method evaluation.
>
> Look up the opcode info of op->common.aml_opcode directly in
> acpi_ps_complete_this_op() and only defer deletion of
> AML_CLASS_ARGUMENT ops when op->common.parent is non-NULL, without
> mutating walk_state->opcode during error unwind (which acpi_ps_parse_loop=
()
> still inspects when skipping failed module-level scopes). Remove the
> now-redundant acpi_ps_delete_parse_tree(*op) inside the AML_REGION_OP /
> AML_DATA_REGION_OP error block in acpi_ps_complete_op(), which previously
> worked around this bug only for region ops and caused a double-free when
> region creation failed on a non-argument child op. Also use
> acpi_ut_delete_generic_state() instead of ACPI_FREE() when draining
> walk_state->control_state in acpi_ps_parse_loop().
>
> Fixes: 5088814a6e93 ("ACPICA: AML parser: attempt to continue loading
> table after error")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D221241
> Signed-off-by: Iurii Trukhin <yuri@trukhin.com>

Please submit this change as a pull request to the upstream ACPICA
project on GitHub.  The kernel will pick it up from there as per

Documentation/driver-api/acpi/linuxized-acpica.rst

> ---
>  drivers/acpi/acpica/psloop.c   | 5 +++--
>  drivers/acpi/acpica/psobject.c | 1 -
>  drivers/acpi/acpica/psparse.c  | 7 +++++--
>  3 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/acpica/psloop.c b/drivers/acpi/acpica/psloop.c
> index 24a57f971c96..0b672a531907 100644
> --- a/drivers/acpi/acpica/psloop.c
> +++ b/drivers/acpi/acpica/psloop.c
> @@ -464,8 +464,9 @@ acpi_status acpi_ps_parse_loop(struct
> acpi_walk_state *walk_state)
>                                                 walk_state->aml =3D
>                                                     parser_state->aml;
>                                         }
> -                                       ACPI_FREE(acpi_ut_pop_generic_sta=
te
> -                                                 (&walk_state->control_s=
tate));
> +                                       acpi_ut_delete_generic_state
> +                                           (acpi_ut_pop_generic_state
> +                                            (&walk_state->control_state)=
);
>                                 }
>                                 op =3D NULL;
>                                 continue;
> diff --git a/drivers/acpi/acpica/psobject.c b/drivers/acpi/acpica/psobjec=
t.c
> index 629cafab1930..f1425b98087b 100644
> --- a/drivers/acpi/acpica/psobject.c
> +++ b/drivers/acpi/acpica/psobject.c
> @@ -559,7 +559,6 @@ acpi_ps_complete_op(struct acpi_walk_state *walk_stat=
e,
>                                                                 node);
>                                         acpi_ns_remove_node((*op)->common=
.node);
>                                         (*op)->common.node =3D NULL;
> -                                       acpi_ps_delete_parse_tree(*op);
>                                 }
>
>                                 status2 =3D
> diff --git a/drivers/acpi/acpica/psparse.c b/drivers/acpi/acpica/psparse.=
c
> index 42ec8abef626..b5110d43ab7a 100644
> --- a/drivers/acpi/acpica/psparse.c
> +++ b/drivers/acpi/acpica/psparse.c
> @@ -108,6 +108,7 @@ acpi_ps_complete_this_op(struct acpi_walk_state *walk=
_state,
>  {
>         union acpi_parse_object *prev;
>         union acpi_parse_object *next;
> +       const struct acpi_opcode_info *op_info;
>         const struct acpi_opcode_info *parent_info;
>         union acpi_parse_object *replacement_op =3D NULL;
>         acpi_status status =3D AE_OK;
> @@ -124,9 +125,11 @@ acpi_ps_complete_this_op(struct acpi_walk_state
> *walk_state,
>
>         /* Delete this op and the subtree below it if asked to */
>
> +       op_info =3D acpi_ps_get_opcode_info(op->common.aml_opcode);
>         if (((walk_state->parse_flags & ACPI_PARSE_TREE_MASK) !=3D
> -            ACPI_PARSE_DELETE_TREE)
> -           || (walk_state->op_info->class =3D=3D AML_CLASS_ARGUMENT)) {
> +            ACPI_PARSE_DELETE_TREE) ||
> +           ((op_info->class =3D=3D AML_CLASS_ARGUMENT) &&
> +            op->common.parent)) {
>                 return_ACPI_STATUS(AE_OK);
>         }
>
> --
> 2.56.0
>
