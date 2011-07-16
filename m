From: Ghislain Landry Tsafack Chetsa
	<ghislain.landry.tsafack.chetsa@ens-lyon.fr>
Subject: Information request about acpi
Date: Sat, 16 Jul 2011 23:59:37 +0200
Message-ID: <20110716235937.56583bwlckigm4sp@webmail.ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=ISO-8859-1;
 DelSp="Yes";
 format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from jabiru.ens-lyon.fr ([140.77.51.2]:39467 "EHLO
	jabiru.ens-lyon.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658Ab1GPWIt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 16 Jul 2011 18:08:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by jabiru.ens-lyon.fr (Postfix) with ESMTP id C0F671EB1B2
	for <linux-acpi@vger.kernel.org>; Sat, 16 Jul 2011 23:59:39 +0200 (CEST)
Received: from jabiru.ens-lyon.fr ([127.0.0.1])
	by localhost (jabiru.ens-lyon.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4c0H5vHTSDgG for <linux-acpi@vger.kernel.org>;
	Sat, 16 Jul 2011 23:59:37 +0200 (CEST)
Received: from agrobate-domu-webmail.ens-lyon.fr (agrobate-domu-webmail.ens-lyon.fr [140.77.51.15])
	by jabiru.ens-lyon.fr (Postfix) with ESMTP id C74E71EB173
	for <linux-acpi@vger.kernel.org>; Sat, 16 Jul 2011 23:59:37 +0200 (CEST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Dear All,

Sorry for disturbing, I am Tsafack Ghislain Landry, Ph.D. student at  
Ecole Normale Superieure of Lyon, France. I have been trying to scale  
the frequency on my Intel E5506 Xeon processor via the cpufreq_acpi  
driver unfortunately (I have tested that feature using the following  
linux kernel versions : 2.6.32, 2.6.38, 2.6.39, 2.6.39.3, and  
3.0.rc7).  This a sample output

# cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq
2128000
#echo 1862000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
1862000
# cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq
2128000

I have tried using the cpufreq-set util as well, but the result is the same.

bellow is the content of the /proc/acpi/processor/CPU0/info file. I  
was wandering whether the "no" value of the parameters  throttling  
control, limit interface can fully explain that behavior.

cat /proc/acpi/processor/CPU0/info
processor id:            0
acpi id:                 1
bus mastering control:   no
power management:        yes
throttling control:      no
limit interface:         no


Regards,


-- 
TSAFACK CHETSA Ghislain Landry
PhD student
INRIA RESO / LIP Laboratory
Ecole Normale Superieure de Lyon
46, allee d'Italie
Lyon Cedex 07
69364
Tel : +33 (0)4 72 72 85 77
Webpage : http://perso.ens-lyon.fr/ghislain.landry.tsafack.chetsa/
