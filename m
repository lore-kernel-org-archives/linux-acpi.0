Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CD818050
	for <linux-acpi@vger.kernel.org>; Thu, 16 Apr 2026 11:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338316; cv=none; b=V0f0E4vO6Xn53qI0yDXXOlFjLPVupAxDh7IDJ8qVah4ECGAnQUGc0OpiSfsb+gy5j0o1TNTbR25u1VUBA8WozXy266y2c59DvRDdU3QpwxEOipOusW62SBxrwsACSIKGz99KCKT0PDTBpUrhkk4Wy7wDb/clBcI+EctoUstH5bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338316; c=relaxed/simple;
	bh=0I1hQQOfuGn7nbMyH5rccfAqTH9pDQIfcJ5oxQD7bhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GUxvUqO4vyvGPhHHaZUVG8nTdv6f7q7g6epNkwPHmAra/r+IeDaFazgm7BQq5trebBYgsLIYZ3qDYo4Vawox1pMpmnFNnnhje57HYTRHE8KPmsWrL5H/1HsVdO100fbXb/Q4O6L0ASZOtSkuwq1JQcYquIOrx6tHz7vD213Im1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QPsa6x4S; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QPsa6x4S"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488b8efed61so5957475e9.1
        for <linux-acpi@vger.kernel.org>; Thu, 16 Apr 2026 04:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776338312; x=1776943112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qd1VopekJz5FiTxyx67UMNjXFF9UUIXLsOl680XCCf0=;
        b=QPsa6x4SOVHFIcDZBLBIeYk2JTeQWGgH1I/3lTPPEg1m3CfUzXMuqkg1W7krRJmT8j
         9PXwgbaKw1ChOtXp26dqLlViRMzLu2DIJH1nHlwCGOHuo0AorVSeI1xTup0gRAjK2bQq
         h2BSS8KanKLcEwhgMrGj/RBly7Hb6Evel3xOgFrrlH8ZgdGbtI87vgHZknkFSC6QYc0y
         d55RgDHO4PWB//XwatZe0m+EOVhgp3plLy2baygOj2HBXeeG0OwHFIqcV8WGnHEDVEXZ
         v1AnAsdtZ6KLTgLiH/Fejvk9cpuu1fdVQ3GsqGpmBMFw9AxIVSFKWzwDj2V/vREOJjHz
         /XlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776338312; x=1776943112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qd1VopekJz5FiTxyx67UMNjXFF9UUIXLsOl680XCCf0=;
        b=sDPqJh6EbIDWkWnRqItkeuFmJjK2CiQAY4ftPmg98A+eTyibJgewd442hjLDR8Rxq+
         pvq9Oxk9lrTJLX564W3PaQpCuqFAIpsU+Bi2yDrRtr4T6Z/OIdiM94FkaT75RfZVJatV
         noGjkURVJXoe6i/GoFpgMHVIPRFhw+j7+UsSA5vcMub4G8hb0wZLnnOs71P7cDqzz8+Y
         uNK9aLyga3+ZlwKVlcL31qJrbRvFNTpy4NPvQbCon6n6IRQEO6IxN6KgUfx+/A9cdviD
         bZmeCwSqZZsRy6bv7UexjL62a36UBxKD4cvla1NZAqwruibsEiYWlgJOt6SVCfOFfkX1
         cQUw==
X-Forwarded-Encrypted: i=1; AFNElJ+bk+vdNuRBO4QCXE0/JwXJAbXMyRgfZL/F5iqHCrEGreq7dZfWVL8be1/FoMI4fdm+qZ8EdV01ckNw@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp+r4Q1oGJTsm/F90a4nr/fHAFigDXFPz/AS0p+v8GuTZY8J8y
	DEFGSS6P75F/zRnZvUbQA20qPoxKbS8WHsvksyFYkyc/Dhq9w5QtMaPwM+kVBjH+TLs=
X-Gm-Gg: AeBDieu2FeMwGFbzoYl8E9wcyUdgkeqECQFDp+ljQDksS2hP7Ur+NIL7mAc+Mn+Xl/L
	zuC4uTmsdDhC00JfEc5fQkEvjkJEC2SB4t6T/EbSuveOZuhhdEvxzlKmntGgRPcFvoBCKmTFIv7
	cJY2aj8FGo91VBsMmLXaMPyYJDZtvec+q1VDHx7tNIzVDCx2EVMjQJHtcsZpaAfdnmeaZAWpinr
	Dzdtfz09hKjG6CNEX1PmYMDilnKUuBIiL3TMj/juDu/3wH+yf7AF+5Flmeq39Gl1XQ0f9QXxpxq
	4ptB0YHcJzibGrSEMrGOZEjNd50pEfGm8dGWYQ0otxeOhAZKNTb4qc9sqABxma4cPb4ayPNagck
	UhDNUieyGn7MjlqrRWLkzlS2rNJuk6U2u52wfL90uLgsn2Lb4p4YgruFb+NjGyPI5bf3v6qxd+b
	DqZ+AhtG8GtEOZqYPGA52PSkjLmKm0BZDJETBPDS3+8P3wHgxqvIQgq14pOnB19lwSD3hqxnwC7
	whW90wuFZztBAHCrY59cwnVnwZjKuiwsxlcOiurOYsMDPL0FyyPrqkk0cunUnsyj5XXZb56r/09
	Gmwy
X-Received: by 2002:a05:600c:31a9:b0:485:3038:72c2 with SMTP id 5b1f17b1804b1-488f4804d19mr27439205e9.17.1776338312207;
        Thu, 16 Apr 2026 04:18:32 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3d5ea9sm13089525f8f.21.2026.04.16.04.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 04:18:31 -0700 (PDT)
Message-ID: <1db425bf-58a9-4768-8c38-3ae25d7662a5@suse.com>
Date: Thu, 16 Apr 2026 13:18:30 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] kernel/module: Decouple klp and ftrace from
 load_module
To: Song Chen <chensong_2000@189.cn>
Cc: rafael@kernel.org, lenb@kernel.org, mturquette@baylibre.com,
 sboyd@kernel.org, viresh.kumar@linaro.org, agk@redhat.com,
 snitzer@kernel.org, mpatocka@redhat.com, bmarzins@redhat.com,
 song@kernel.org, yukuai@fnnas.com, linan122@huawei.com,
 jason.wessel@windriver.com, danielt@kernel.org, dianders@chromium.org,
 horms@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, paulmck@kernel.org, frederic@kernel.org,
 mcgrof@kernel.org, da.gomez@kernel.org, samitolvanen@google.com,
 atomlin@atomlin.com, jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
 pmladek@suse.com, joe.lawrence@redhat.com, rostedt@goodmis.org,
 mhiramat@kernel.org, mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
 live-patching@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-raid@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
 netdev@vger.kernel.org
References: <20260413080701.180976-1-chensong_2000@189.cn>
 <1191caf5-6a61-4622-a15e-854d3701f4fc@suse.com>
 <a35f5f94-7d5a-4347-974b-b270c89ef241@189.cn>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <a35f5f94-7d5a-4347-974b-b270c89ef241@189.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/15/26 8:43 AM, Song Chen wrote:
> On 4/14/26 22:33, Petr Pavlu wrote:
>> On 4/13/26 10:07 AM, chensong_2000@189.cn wrote:
>>> diff --git a/include/linux/module.h b/include/linux/module.h
>>> index 14f391b186c6..0bdd56f9defd 100644
>>> --- a/include/linux/module.h
>>> +++ b/include/linux/module.h
>>> @@ -308,6 +308,14 @@ enum module_state {
>>>       MODULE_STATE_COMING,    /* Full formed, running module_init. */
>>>       MODULE_STATE_GOING,    /* Going away. */
>>>       MODULE_STATE_UNFORMED,    /* Still setting it up. */
>>> +    MODULE_STATE_FORMED,
>>
>> I don't see a reason to add a new module state. Why is it necessary and
>> how does it fit with the existing states?
>>
> because once notifier fails in state MODULE_STATE_UNFORMED (now only ftrace has someting to do in this state), notifier chain will roll back by calling blocking_notifier_call_chain_robust, i'm afraid MODULE_STATE_GOING is going to jeopardise the notifers which don't handle it appropriately, like:
> 
> case MODULE_STATE_COMING:
>      kmalloc();
> case MODULE_STATE_GOING:
>      kfree();

My understanding is that the current module "state machine" operates as
follows. Transitions marked with an asterisk (*) are announced via the
module notifier.

---> UNFORMED --*> COMING --*> LIVE --*> GOING -.
        ^            |                     ^    |
        |            '---------------------*    |
        '---------------------------------------'

The new code aims to replace the current ftrace_module_init() call in
load_module(). To achieve this, it adds a notification for the UNFORMED
state (only when loading a module) and introduces a new FORMED state for
rollback. FORMED is purely a fake state because it never appears in
module::state. The new structure is as follows:

        ,--*> (FORMED)
        |
--*> UNFORMED --*> COMING --*> LIVE --*> GOING -.
        ^            |                     ^    |
        |            '---------------------*    |
        '---------------------------------------'

I'm afraid this is quite complex and inconsistent. Unless it can be kept
simple, we would be just replacing one special handling with a different
complexity, which is not worth it.

>>
>>> +    if (err)
>>> +        goto ddebug_cleanup;
>>>         /* Finally it's fully formed, ready to start executing. */
>>>       err = complete_formation(mod, info);
>>> -    if (err)
>>> +    if (err) {
>>> +        blocking_notifier_call_chain_reverse(&module_notify_list,
>>> +                MODULE_STATE_FORMED, mod);
>>>           goto ddebug_cleanup;
>>> +    }
>>>   -    err = prepare_coming_module(mod);
>>> +    err = prepare_module_state_transaction(mod,
>>> +                MODULE_STATE_COMING, MODULE_STATE_GOING);
>>>       if (err)
>>>           goto bug_cleanup;
>>>   @@ -3522,7 +3519,6 @@ static int load_module(struct load_info *info, const char __user *uargs,
>>>       destroy_params(mod->kp, mod->num_kp);
>>>       blocking_notifier_call_chain(&module_notify_list,
>>>                        MODULE_STATE_GOING, mod);
>>
>> My understanding is that all notifier chains for MODULE_STATE_GOING
>> should be reversed.
> yes, all, from lowest priority notifier to highest.
> I will resend patch 1 which was failed due to my proxy setting.

What I meant here is that the call:

blocking_notifier_call_chain(&module_notify_list, MODULE_STATE_GOING, mod);

should be replaced with:

blocking_notifier_call_chain_reverse(&module_notify_list, MODULE_STATE_GOING, mod);

> 
>>
>>> -    klp_module_going(mod);
>>>    bug_cleanup:
>>>       mod->state = MODULE_STATE_GOING;
>>>       /* module_bug_cleanup needs module_mutex protection */
>>
>> The patch removes the klp_module_going() cleanup call in load_module().
>> Similarly, the ftrace_release_mod() call under the ddebug_cleanup label
>> should be removed and appropriately replaced with a cleanup via
>> a notifier.
>>
>     err = prepare_module_state_transaction(mod,
>                 MODULE_STATE_UNFORMED, MODULE_STATE_FORMED);
>     if (err)
>         goto ddebug_cleanup;
> 
> ftrace will be cleanup in blocking_notifier_call_chain_robust rolling back.
> 
>     err = prepare_module_state_transaction(mod,
>                 MODULE_STATE_COMING, MODULE_STATE_GOING);
> 
> each notifier including ftrace and klp will be cleanup in blocking_notifier_call_chain_robust rolling back.
> 
> if all notifiers are successful in MODULE_STATE_COMING, they all will be clean up in
>  coming_cleanup:
>     mod->state = MODULE_STATE_GOING;
>     destroy_params(mod->kp, mod->num_kp);
>     blocking_notifier_call_chain(&module_notify_list,
>                      MODULE_STATE_GOING, mod);
> 
> if  something wrong underneath.

My point is that the patch leaves a call to ftrace_release_mod() in
load_module(), which I expected to be handled via a notifier.

-- 
Thanks,
Petr
