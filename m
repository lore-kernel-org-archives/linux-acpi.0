Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB78C2D0E4
	for <linux-acpi@archiver.kernel.org>; Fri, 27 Nov 2020 10:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29611221FD
	for <linux-acpi@archiver.kernel.org>; Fri, 27 Nov 2020 10:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCeHaVqt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgK0KBH (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 27 Nov 2020 05:01:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgK0KBH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Nov 2020 05:01:07 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F14C0613D1
        for <linux-acpi@vger.kernel.org>; Fri, 27 Nov 2020 02:01:06 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id m19so1079788ejl.11
        for <linux-acpi@vger.kernel.org>; Fri, 27 Nov 2020 02:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=exzORGr4gj+qwmMnfHHCG09nrcTyYwFGnD1MUc/YRl0=;
        b=cCeHaVqtsVQXZIyo3sbi0uNLQjqNbXxtvjvXDxYMvG4JlJecb5MN4YnD6qpQyAdzYP
         uiabcG3lRoFVmMLXzy2HOPONgRYtxqktBLd3BswrUpgP59vjt/6yL354e5dfQdp6H4dr
         H3K8yQwZnvLdABnFxqKZ8FIkoAZuoBaxivormEh8IUIaBpwDAQDzIA3vmxN17MMPz6FX
         low/CatgPY7uJMD6zQ36sJ0tJvz5qy2Py2UQ+LEEnV2w66ltwCuYnZa9vYCArqy+mqlW
         Xz8xtlFHiY2bPyJiAdhflBhDFRyBY1hfnqNjbZcu4Gjb+RAniwMSef9us2ZtXMdYjI+F
         YgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=exzORGr4gj+qwmMnfHHCG09nrcTyYwFGnD1MUc/YRl0=;
        b=WWhpwqWvgOOgOUmqaOlmWYJ2HYX1MI9IsjUdoHDVJznciQR/qE4ap4fV9xorHpoSC6
         Vn6UR0vaMy47Ygut4ElOX4SC1NdHdmmQeDWOf7owtKHN7AeCOeCqivhnDpwISmXX7dis
         cpKAPEqFga8EhHiuHj25+UKg9sK9QbI7K+XZfTjGxm0fQdpVmDxOfSD7uosDeJdxF0Me
         pnUWqvoEu6f1EV6jOiedGA31lkkApBiF/7qeomVO6uGzkCkKOOeAcrpjtmkZ81LvJZO3
         bnQt9uy8XfGj6M+SIm3Nl4oYg47+8rqO5YmCpAgDPQgQ5HhUmOf5EngFN3VUdPHmFh9Q
         Ucyg==
X-Gm-Message-State: AOAM530UWzUUP9S6KEsR1vg2FDpGAp11PVPY4l5LOOEyWVqDiAghnEJ3
        IZhXwmUz5xFEN20vGr8dLpP0vOF/Mg==
X-Google-Smtp-Source: ABdhPJyaHSQZDGqGfcShZnVcI10L2u0VMlPWHkmF9zoX8pc510Ly7szRN7aHNMmt1PW9MEvKMpLLTQ==
X-Received: by 2002:a17:906:4809:: with SMTP id w9mr914009ejq.139.1606471265235;
        Fri, 27 Nov 2020 02:01:05 -0800 (PST)
Received: from localhost.localdomain ([46.53.253.250])
        by smtp.gmail.com with ESMTPSA id p7sm4785000edy.76.2020.11.27.02.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 02:01:04 -0800 (PST)
Date:   Fri, 27 Nov 2020 13:01:02 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: evaluation order bug in acpi_pic_sci_set_trigger() ?
Message-ID: <20201127100102.GA132507@localhost.localdomain>
References: <20201125195906.GA3809000@localhost.localdomain>
 <CAJZ5v0iUg2DD+o3AVfLqxAqX4vAnTC1o1kK=-nTcnkk2c36DPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iUg2DD+o3AVfLqxAqX4vAnTC1o1kK=-nTcnkk2c36DPA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 26, 2020 at 03:32:37PM +0100, Rafael J. Wysocki wrote:
> On Wed, Nov 25, 2020 at 8:59 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >
> > acpi_pic_sci_set_trigger() contains the following code:
> >
> >         /* Real old ELCR mask */
> >         old = inb(0x4d0) | (inb(0x4d1) << 8);
> >
> > Operand evalution order is not guaranteed for binary or.
> > I wonder if this is a bug?
> 
> Does the ordering matter in practice?

I have no idea, this is why I'm asking. :-)
